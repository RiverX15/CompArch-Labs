module leftShifter(output [27:0] out, input [25:0] in);
    assign out=in<<2;
endmodule