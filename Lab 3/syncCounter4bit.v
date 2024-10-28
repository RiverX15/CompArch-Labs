`include "jkFF.v"

module syncCounter(input clk, input rst, output [3:0] q);
    wire q01;
    assign q01=q[0]&q[1];
    wire q012;
    assign q012=q01&q[2];
    jkFF f0(1'b1, 1'b1, clk, rst, q[0]);
    jkFF f1(q[0], q[0], clk, rst, q[1]);
    jkFF f2(q01, q01, clk, rst, q[2]);
    jkFF f3(q012, q012, clk, rst, q[3]);
endmodule