`include "mux2to1_32bit.v"
`include "mux3to1_32bit.v"
`include "and32bit.v"
`include "or32bit.v"
`include "fullAdder32bit.v"

module alu(output cout, output [31:0] ans, input [1:0] op, input binvert, input [31:0] in1,
            input [31:0] in2, input cin);
    wire [31:0] andOut, orOut, faOut, iin2;
    mux2to1_32bit m1(iin2, binvert, in2, ~in2);
    and32bit a1(andOut, in1, iin2);
    or32bit o1(orOut, in1, iin2);
    fullAdder32bit f1(cout, faOut, in1, iin2, cin);
    mux3to1_32bit m2(ans, op, andOut, orOut, faOut);
endmodule