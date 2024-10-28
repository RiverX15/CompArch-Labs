module DECODER(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	input x,y,z;
	output d0,d1,d2,d3,d4,d5,d6,d7;
	wire x0,y0,z0;
	not n1(x0,x);
	not n2(y0,y);
	not n3(z0,z);
	and a0(d0,x0,y0,z0);
	and a1(d1,x0,y0,z);
	and a2(d2,x0,y,z0);
	and a3(d3,x0,y,z);
	and a4(d4,x,y0,z0);
	and a5(d5,x,y0,z);
	and a6(d6,x,y,z0);
	and a7(d7,x,y,z);
endmodule

module FADDER(s,c,x,y,z);
	input x,y,z;
	wire d0,d1,d2,d3,d4,d5,d6,d7;
	output s,c;
	DECODER dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	assign	s=d1|d2|d4|d7,
			c=d3|d5|d6|d7;	
endmodule

// REVERSE THE ARRAY, USE [7:0] AND [6:0] NOT [0:7], [0:6]
// RUN WITH BOTH THEN OBSERVE
// PASS ARRAY FROM MSB TO LSB ORDER IN FUNCTION CALL. THIS CODE WILL REVERSE A AND PROCEED AUTOMATICALLY.

module FADDER_8bit(s,cout,a,b,cin);
	input [7:0] a,b;
	input cin;
	output [7:0] s;
	output cout;
	wire [6:0] c;
	FADDER f0(s[0], c[0], a[0], b[0], cin);
	FADDER f1(s[1], c[1], a[1], b[1], c[0]);
	FADDER f2(s[2], c[2], a[2], b[2], c[1]);
	FADDER f3(s[3], c[3], a[3], b[3], c[2]);
	FADDER f4(s[4], c[4], a[4], b[4], c[3]);
	FADDER f5(s[5], c[5], a[5], b[5], c[4]);
	FADDER f6(s[6], c[6], a[6], b[6], c[5]);
	FADDER f7(s[7], cout, a[7], b[7], c[6]);
endmodule

module FADDER_32bit(s, cout, a, b, cin);
	input [31:0] a,b;
	input cin;
	output [31:0] s;
	output cout;
	wire [2:0] c;
	FADDER_8bit f0(s[7:0], c[0], a[7:0], b[7:0], cin);
	FADDER_8bit f1(s[15:8], c[1], a[15:8], b[15:8], c[0]);
	FADDER_8bit f2(s[23:16], c[2], a[23:16], b[23:16], c[1]);
	FADDER_8bit f3(s[31:24], cout, a[31:24], b[31:24], c[2]);
endmodule

module testbench;
	reg [31:0] a,b;
	reg cin;
	wire [31:0] s;
	wire cout;
	FADDER_32bit f(s,cout,a,b,cin);
	initial
		begin
			$monitor(,$time," a=%b | b=%b | cin=%b | s=%b | cout=%b", a, b, cin, s, cout);
		end
	initial
		begin
			#0 a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; cin=1'b0;
			#4 a=32'b10000000000000000000000000000000; b=32'b01111111111111111111111111111111; cin=1'b0;
			#4 a=32'b10100000010000000100000100010001; b=32'b00000000000000001000000010000000; cin=1'b1;
			#4 a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; cin=1'b1;
			#4 a=32'b11111111111111111111111111111111; b=32'b00000000000000000000000000000001; cin=1'b0;
			#4 a=32'b00000000000000000000100000001110; b=32'b00000000000000010000000100000000; cin=1'b0;
			#4 a=32'b11111111111111111111111111111111; b=32'b00000000000000000000000000000001; cin=1'b1;
		end
endmodule