`include "jkFF.v"

module tb_jkFF;
    reg j,k,clk,rst;
    wire q;
    jkFF jkff(j,k,clk,rst,q);
    initial begin
        forever begin
            clk=0;
            #5 clk=1;
            #5 clk=0;
        end
    end
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        $monitor($time, " j k clk rst q = %b %b %b %b %b ", j,k,clk,rst,q);
        #2 j=0; k=0; rst=1;
        #5 j=0; k=0; rst=0;
        #5 j=0; k=1; rst=0;
        #5 j=1; k=0; rst=0;
        #5 j=1; k=1; rst=0;
        #5 j=0; k=0; rst=0;
        #5 j=0; k=1; rst=0;
        #5 j=1; k=0; rst=0;
        #5 j=1; k=1; rst=0;
        #100 $finish;
    end
endmodule