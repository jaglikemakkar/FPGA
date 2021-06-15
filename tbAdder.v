module tb_4bitadder();
    reg [3:0] a,b;
    reg cin;
    wire [3:0] out;
    reg[31:0] lut[0:6];
    wire cout;
    reg clock;
    fgpa fba(.i0(a[0]), .i1(a[1]), .i2(a[2]), .i3(a[3]), .i4(b[0]), .i5(b[1]), .i6(b[2]), .i7(b[3]), .cin(cin), .ofba(out), .cout(cout), .clock(clock));

    initial clock = 0;
    always #10 clock = ~clock;

    initial
        begin
            $readmemh("confAdder.bin", lut);
            fba.l1_fba.mem[31:0] = lut[0];
            fba.l1_fba.mem[32] = lut[1];
            fba.l2_fba.mem[31:0] = lut[2];
            fba.l2_fba.mem[32] = lut[3];
            fba.l3_fba.mem[31:0] = lut[4];
            fba.l3_fba.mem[32] = lut[5];
            fba.l4_fba.mem[31:0] = lut[0];
            fba.l4_fba.mem[32] = lut[1];
            fba.l5_fba.mem[31:0] = lut[2];
            fba.l5_fba.mem[32] = lut[3];
            fba.l6_fba.mem[31:0] = lut[4];
            fba.l6_fba.mem[32] = lut[5];
            
            a = 4'b1110;
            b = 4'b0110;
            cin = 1'b1;
            #20
            $display("a : %b, b : %b, cin: %b, out: %b, cout: %b", a, b, cin, out, cout);
        end

    initial 
        begin
            #100 $finish;
        end
    initial
        begin
            $dumpfile("fourBitAdder.vcd");
            $dumpvars;
        end
endmodule