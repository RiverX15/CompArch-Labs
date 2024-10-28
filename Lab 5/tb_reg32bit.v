`include "register32bit.v"

module tb_reg32bit;
    reg [31:0] d;
    reg clk, reset;
    wire [31:0] q;
    register32bit reg1(q, d, clk, reset);
    initial clk=1'b0;
    always #5 clk=~clk;
    initial begin
        $monitor($time, " d clk reset q = %h %b %b %h %0d", d, clk, reset, q, $time);
        #2 reset=1'b0;
        #17 reset=1'b1;
        #20 d=32'hAFAFAFAF;
        #100 $finish;
    end
endmodule