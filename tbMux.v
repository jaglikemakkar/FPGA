module tb_mux();
    reg [7:0] in;
    wire out;
    reg [2:0] con;
    reg clock;
    reg[31:0] lut[1:0];
    fgpa inst(.o(out), .i0(in[0]), .i1(in[1]), .i2(in[2]), .i3(in[3]), .i4(in[4]), .i5(in[5]), .i6(in[6]), .i7(in[7]), .c1(con[0]), .c2(con[1]), .c3(con[2]), .clock(clock));
    initial clock = 0;
    always #10 clock = ~clock;

    initial
        begin
            $readmemh("confMux.bin", lut);
            inst.l1_mux.mem[31:0] = lut[0];
            inst.l1_mux.mem[32] = lut[1];
            inst.l2_mux.mem[31:0] = lut[0];
            inst.l2_mux.mem[32] = lut[1];
            inst.l3_mux.mem[31:0] = lut[0];
            inst.l3_mux.mem[32] = lut[1];
            inst.l4_mux.mem[31:0] = lut[0];
            inst.l4_mux.mem[32] = lut[1];
            inst.l5_mux.mem[31:0] = lut[0];
            inst.l5_mux.mem[32] = lut[1];
            inst.l6_mux.mem[31:0] = lut[0];
            inst.l6_mux.mem[32] = lut[1];
            inst.l7_mux.mem[31:0] = lut[0];
            inst.l7_mux.mem[32] = lut[1];

            in = 8'b00000001;
            con = 3'b000;
            #20
            $display("in : %b, con : %b, out: %b", in, con, out);
        end

    initial
        begin
            #100 $finish;
        end

    initial
        begin
            $dumpfile("mux.vcd");
            $dumpvars;
        end
endmodule