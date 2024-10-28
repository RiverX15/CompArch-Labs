module mux2to1(out,sel,in1,in2);
	input in1,in2,sel;
	output out;
	wire not_sel,a1,a2;
	not (not_sel,sel);
	and (a1,sel,in2);
	and (a2,not_sel,in1);
	or(out,a1,a2);
endmodule
module mux3to1(out, sel, in1, in2, in3);
	input in1, in2, in3;
	input [1:0] sel;
	output out;
	wire i0;
	mux2to1 m1(i0, sel[0], in1, in2);
	mux2to1 m2(out, sel[1], i0, in3);
endmodule
/* module tb_3to1mux;
	reg inp1, inp2, inp3;
	reg [1:0] sel;
	wire out;
	mux3to1 m1(out, sel, inp1, inp2, inp3);
	initial
		begin
			$monitor("inp1=%b, inp2=%b, inp3=%b, sel=%b, out=%b\n", inp1, inp2, inp3, sel, out);
			inp1=1'b0;
			inp2=1'b1;
			inp3=1'b0;
			sel=2'b00;
			#100 sel=2'b01;
			#100 sel=2'b10;
			#100 sel=2'b11;
			#1000 $finish;
		end
endmodule */
module bit32_3to1mux(out, sel, in1, in2, in3);
	input [31:0] in1, in2, in3;
	output [31:0] out;
	input [1:0] sel;
	genvar j;
	generate for (j=0; j<32; j=j+1) begin: mux_loop
		mux3to1 m1(out[j], sel, in1[j], in2[j], in3[j]);
		end
	endgenerate
endmodule
module tb_32bit3to1mux;
	reg [31:0] INP1, INP2, INP3;
	reg [1:0] SEL;
	wire [31:0] OUT;
	bit32_3to1mux M1(OUT, SEL, INP1, INP2, INP3);
	initial
		begin
			$monitor("INP1=%b, INP2=%b, INP3=%b, SEL=%b, OUT=%b\n", INP1, INP2, INP3, SEL, OUT);
			INP1=32'b10101010101010101010101010101010;
			INP2=32'b01010101010101010101010101010101;
			INP3=32'b01010101010101010101010101001011;
			SEL=2'b00;
			#100 SEL=2'b01;
			#100 SEL=2'b10;
			#100 SEL=2'b11;
			#1000 $finish;
		end
endmodule