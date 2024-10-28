`include "syncCounter4bit.v"

module tb_syncCtr;
    reg clk, rst;
    wire [3:0] q;
    syncCounter ctr(clk, rst, q);
    initial clk=0;
    always #2 clk=~clk;
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        $monitor($time, " clk rst q = %b %b %b", clk, rst, q);
    end
    initial begin
        rst=1'b1;
        #4 rst=1'b0;
        #100 $finish;
    end
endmodule