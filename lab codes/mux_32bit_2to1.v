module mux2to1(out,sel,in1,in2);
	input in1,in2,sel;
	output out;
	wire not_sel,a1,a2;
	not (not_sel,sel);
	and (a1,sel,in2);
	and (a2,not_sel,in1);
	or(out,a1,a2);
endmodule
module bit32_2to1mux(out, sel, in1, in2);
	input [31:0] in1, in2;
	output [31:0] out;
	input sel;
	genvar j;
	generate for (j=0; j<32; j=j+1) begin: mux_loop
		mux2to1 m1(out[j], sel, in1[j], in2[j]);
		end
	endgenerate
endmodule
module tb_32bit2to1mux;
	reg [31:0] INP1, INP2;
	reg SEL;
	wire [31:0] OUT;
	bit32_2to1mux M1(OUT, SEL, INP1, INP2);
	initial
		begin
			$monitor("INP1=%b, INP2=%b, SEL=%b, OUT=%b\n", INP1, INP2, SEL, OUT);
			INP1=32'b10101010101010101010101010101010;
			INP2=32'b01010101010101010101010101010101;
			SEL=1'b0;
			#100 SEL=1'b1;
			#1000 $finish;
		end
endmodule