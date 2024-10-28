module FA_dataflow (Cout, Sum,In1,In2,Cin);
	input In1,In2;
	input Cin;
	output Cout;
	output Sum;
	assign {Cout,Sum}=In1+In2+Cin;
endmodule
module bit32FA (Cout, Sum, In1, In2, Cin);
	input [31:0] In1, In2;
	input Cin;
	output [31:0] Sum;
	output Cout;
	assign {Cout, Sum}=In1+In2+Cin;
endmodule
module tb32bitFA;
	reg [31:0] In1, In2;
	reg Cin;
	wire [31:0] Sum;
	wire Cout;
	bit32FA a1 (Cout, Sum, In1, In2, Cin);
	initial
		begin
			$monitor("In1=%b, In2=%b, Cin=%b, Sum=%b, Cout=%b\n", In1, In2, Cin, Sum, Cout);
			In1=32'b10000101100001011000010110000101;
			In2=32'b01000010110000101100001011000010;
			Cin=1'b0;
			#100 Cin=1'b1;
			#100 In2=32'b01110010110000101100001011000110;
			#100
			In1=32'b11111111111111111111111111111111;
			In2=32'b11111111111111111111111111111111;
			Cin=1'b1;
			#400 $finish;
		end
endmodule