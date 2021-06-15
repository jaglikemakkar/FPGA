module Counter_test();
    reg clock,c,d;
    reg [3:0] in;
    reg [31:0] test_mem[0:14];
    wire [3:0] out;
    fgpa inst(.omux(out),.clock(clock),.c1(c),.c2(d));

    initial
    begin
        $readmemh("confCounter.bin",test_mem);
        inst.l1.mem[31:0]=test_mem[0];
        inst.l1.mem[32]=1'b1;
        inst.l2.mem[31:0]=test_mem[1];
        inst.l2.mem[32]=1'b1;
        inst.l3.mem[31:0]=test_mem[2];
        inst.l3.mem[32]=1'b1;
        inst.l4.mem[31:0]=test_mem[3];
        inst.l4.mem[32]=1'b1;
        inst.l5.mem[31:0]=test_mem[4];
        inst.l5.mem[32]=1'b1;
        inst.l6.mem[31:0]=test_mem[5];
        inst.l6.mem[32]=1'b1;
        inst.l7.mem[31:0]=test_mem[6];
        inst.l7.mem[32]=1'b1;
        inst.l8.mem[31:0]=test_mem[7];
        inst.l8.mem[32]=1'b1;
        inst.l9.mem[31:0]=test_mem[8];
        inst.l9.mem[32]=1'b1;
        inst.l10.mem[31:0]=test_mem[9];
        inst.l10.mem[32]=1'b1;
        inst.l11.mem[31:0]=test_mem[10];
        inst.l11.mem[32]=1'b1;
        inst.l12.mem[31:0]=test_mem[11];
        inst.l12.mem[32]=1'b1;
        inst.l13.mem[31:0]=test_mem[12];
        inst.l13.mem[32]=1'b0;
        inst.l14.mem[31:0]=test_mem[12];
        inst.l14.mem[32]=1'b0;
        inst.l15.mem[31:0]=test_mem[12];
        inst.l15.mem[32]=1'b0;
        inst.l16.mem[31:0]=test_mem[12];
        inst.l16.mem[32]=1'b0;

        inst.sb_mux.configure=test_mem[13];
    end
  
    initial clock=0;
    always #10 clock = ~clock;

    initial
        begin
        c=1'b1;d=1'b0;
        #100
        $display("c : %b, d : %b, out: %b", c, d, out);
        c=1'b0;d=1'b0;
        #100
        $display("c : %b, d : %b, out: %b", c, d, out);
        c=1'b0;d=1'b1;
        #100
        $display("c : %b, d : %b, out: %b", c, d, out);
        c=1'b1;d=1'b0;
        #100
        $display("c : %b, d : %b, out: %b", c, d, out);
        c=1'b0;d=1'b0;
        #100
        $display("c : %b, d : %b, out: %b", c, d, out);
        c=1'b0;d=1'b1;
        #100
        $display("c : %b, d : %b, out: %b", c, d, out);
        c=1'b1;d=1'b0;
        #100
        $display("c : %b, d : %b, out: %b", c, d, out);
        end
    initial
        begin
        $dumpfile("counter.vcd");
        $dumpvars;
        end
    initial
        #800
        $finish;
endmodule

      
// 00005555
// 00006666
// 00007878
// 00007F80
// 00005555
// 00009999
// 0000E1E1
// 0000FE01
// 0000AAAA
// 0000CCCC
// 0000F0F0
// 0000FF00
// 00AACCF0
// 8421
