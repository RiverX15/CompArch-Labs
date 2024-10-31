module alu(output [3:0] x, input [3:0] a, input [3:0] b, input [2:0] opcode);
    wire [3:0] val[0:7];
    assign val[0]=a+b;
    assign val[1]=a-b;
    assign val[2]=a^b;
    assign val[3]=a|b;
    assign val[4]=a&b;
    assign val[5]=~(a|b);
    assign val[6]=~(a&b);
    assign val[7]=~(a^b);
    assign x=val[opcode];
endmodule