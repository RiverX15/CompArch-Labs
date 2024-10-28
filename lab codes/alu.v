module bit32AND (out,in1,in2);
	input [31:0] in1,in2;
	output [31:0] out;
	assign {out}=in1 &in2;
endmodule
module bit32OR (out,in1,in2);
	input [31:0] in1,in2;
	output [31:0] out;
	assign {out}=in1 | in2;
endmodule
module bit32NOT (out,in1);
	input [31:0] in1;
	output [31:0] out;
	assign {out}=~in1;
endmodule
module bit32FA (Cout, Sum, In1, In2, Cin);
	input [31:0] In1, In2;
	input Cin;
	output [31:0] Sum;
	output Cout;
	assign {Cout, Sum}=In1+In2+Cin;
endmodule
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
module ALU (out, cout, sel, in1, in2, cin, binv);
	input [31:0] in1, in2;
	input [1:0] sel;
	input cin, binv;
	output [31:0] out;
	output cout;
	wire [31:0] i0, i1, i2, not_in2;
	bit32NOT n1 (not_in2, in2);
	bit32_2to1mux m1 (in2, binv, in2, not_in2);
	bit32AND a1 (i0, in1, in2);
	bit32OR o1 (i1, in1, in2);
	bit32FA fa1 (cout, i2, in1, in2, cin);
	bit32_3to1mux m2 (out, sel, i0, i1, i2);
endmodule
module tbALU;
	reg Binvert, Carryin;
	reg [1:0] Operation;
	reg [31:0] a,b;
	wire [31:0] Result;
	wire CarryOut;
	ALU a1 (Result, CarryOut, Operation, a, b, Carryin, Binvert);
	initial
		begin
			$monitor("a=%b, b=%b, Carryin=%b, Binvert=%b, Operation=%b, Result=%b, CarryOut=%b\n", a, b, Carryin, Binvert, Operation, Result, CarryOut);
			a=32'ha5a5a5a5;
			b=32'h5a5a5a5a;
			Binvert=1'b0;
			Carryin=1'b0;
			Operation=2'b00; //must perform AND resulting in zero
			#100 Operation=2'b01; //OR
			#100 Operation=2'b10; //ADD
			#100 Binvert=1'b1;//SUB
			#200 $finish;
		end
endmodule
