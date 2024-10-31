module evenParityGenerator(output [4:0] out, input [3:0] in);
    wire pb;
    assign pb=(~in[3] & ~in[2] & ~in[1] & in[0]) | (~in[3] & ~in[2] & in[1] & ~in[0]) | 
                (~in[3] & in[2] & ~in[1] & ~in[0]) | (in[3] & ~in[2] & ~in[1] & ~in[0]) | 
                (~in[3] & in[2] & in[1] & in[0]) | (in[3] & ~in[2] & in[1] & in[0]) | 
                (in[3] & in[2] & ~in[1] & in[0]) | (in[3] & in[2] & in[1] & ~in[0]);
    assign out={pb,in};
endmodule