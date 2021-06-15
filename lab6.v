module logic_tile(out, clock, in1, in2, in3, in4, in5);
    input in1, in2, in3, in4, in5, clock;
    output out;
    reg q, qbar;
    initial q = 1'b0;
    wire out, d;
    reg[32:0] mem;
    assign d = mem[{in5, in4, in3, in2, in1}];
    always@(posedge clock)
    begin
        q <= d;
        qbar = !d;
    end
    assign out = (q & mem[32]) | (d & ~mem[32]);
endmodule


module switch_box_4x4(out, in);
    input [3:0] in;
    output [3:0] out;
    reg [15:0] configure;
    assign out[0] = (in[0]&configure[0])|(in[1]&configure[1])|(in[2]&configure[2])|(in[3]&configure[3]); 
    assign out[1] = (in[0]&configure[4])|(in[1]&configure[5])|(in[2]&configure[6])|(in[3]&configure[7]);
    assign out[2] = (in[0]&configure[8])|(in[1]&configure[9])|(in[2]&configure[10])|(in[3]&configure[11]);
    assign out[3] = (in[0]&configure[12])|(in[1]&configure[13])|(in[2]&configure[14])|(in[3]&configure[15]);
endmodule

module fgpa(i0, i1, i2, i3, i4, i5, i6, i7, c1, c2, c3, cin, ofba, omux, o, cout, clock);
    input i0,i1,i2,i3,i4,i5,i6,i7,c1,c2,c3,cin,clock;
    wire carry;
    output [3:0] ofba, omux;
    output cout,o;

    logic_tile l1_fba(.out(ofba[0]), .clock(clock), .in1(cin), .in2(i5), .in3(i4), .in4(i1), .in5(i0));
    logic_tile l2_fba(.out(ofba[1]), .clock(clock), .in1(cin), .in2(i5), .in3(i4), .in4(i1), .in5(i0));
    logic_tile l3_fba(.out(carry), .clock(clock), .in1(cin), .in2(i5), .in3(i4), .in4(i1), .in5(i0));
    logic_tile l4_fba(.out(ofba[2]), .clock(clock), .in1(carry), .in2(i7), .in3(i6), .in4(i3), .in5(i2));
    logic_tile l5_fba(.out(ofba[3]), .clock(clock), .in1(carry), .in2(i7), .in3(i6), .in4(i3), .in5(i2));
    logic_tile l6_fba(.out(cout), .clock(clock), .in1(carry), .in2(i7), .in3(i6), .in4(i3), .in5(i2));

    wire o1, o2, o3, o4, o5, o6;
    logic_tile l1_mux(.out(o1), .clock(clock), .in1(c1), .in2(i0), .in3(i1), .in4(1'b0), .in5(1'b0)); // 000000E4
    logic_tile l2_mux(.out(o2), .clock(clock), .in1(c1), .in2(i2), .in3(i3), .in4(1'b0), .in5(1'b0));
    logic_tile l3_mux(.out(o3), .clock(clock), .in1(c1), .in2(i4), .in3(i5), .in4(1'b0), .in5(1'b0));
    logic_tile l4_mux(.out(o4), .clock(clock), .in1(c1), .in2(i6), .in3(i7), .in4(1'b0), .in5(1'b0));

    logic_tile l5_mux(.out(o5), .clock(clock), .in1(c2), .in2(o1), .in3(o2), .in4(1'b0), .in5(1'b0));
    logic_tile l6_mux(.out(o6), .clock(clock), .in1(c2), .in2(o3), .in3(o4), .in4(1'b0), .in5(1'b0));

    logic_tile l7_mux(.out(o), .clock(clock), .in1(c3), .in2(o5), .in3(o6), .in4(1'b0), .in5(1'b0));

    wire tout[11:0];
    wire [3:0] cnt;
 
    logic_tile l1(.out(tout[0]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l2(.out(tout[1]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l3(.out(tout[2]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l4(.out(tout[3]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l5(.out(tout[4]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l6(.out(tout[5]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l7(.out(tout[6]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l8(.out(tout[7]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l9(.out(tout[8]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l10(.out(tout[9]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l11(.out(tout[10]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));
    logic_tile l12(.out(tout[11]), .clock(clock), .in1(cnt[0]), .in2(cnt[1]), .in3(cnt[2]), .in4(cnt[3]), .in5(1'b0));

    logic_tile l13(.out(omux[0]), .clock(clock), .in1(tout[0]), .in2(tout[4]), .in3(tout[8]), .in4(c2), .in5(c1));
    logic_tile l14(.out(omux[1]), .clock(clock), .in1(tout[1]), .in2(tout[5]), .in3(tout[9]), .in4(c2), .in5(c1));
    logic_tile l15(.out(omux[2]), .clock(clock), .in1(tout[2]), .in2(tout[6]), .in3(tout[10]), .in4(c2), .in5(c1));
    logic_tile l16(.out(omux[3]), .clock(clock), .in1(tout[3]), .in2(tout[7]), .in3(tout[11]), .in4(c2), .in5(c1));

    switch_box_4x4 sb_mux(.out(cnt), .in(omux));

endmodule