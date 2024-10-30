module mux3to1_32bit(output [31:0] out, input [1:0] sel, input [31:0] in1, input [31:0] in2,
                    input [31:0] in3);
    assign out=(sel[1])?(in3):((sel[0])?(in2):(in1));
endmodule