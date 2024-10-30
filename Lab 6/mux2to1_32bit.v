module mux2to1_32bit(output [31:0] out, input sel, input [31:0] in1, input [31:0] in2);
    // reg [31:0] out;
    assign out=sel?in2:in1;
endmodule