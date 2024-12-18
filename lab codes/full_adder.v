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

module testbench;
	reg x,y,z;
	wire s,c;
	FADDER f1(s,c,x,y,z);
	initial
		$monitor(,$time,"x=%b, y=%b, z=%b, s=%b, c=%b",x,y,z,s,c);
	initial
		begin
			#0 x=1'b0; y=1'b0; z=1'b0;
			#4 x=1'b0; y=1'b1; z=1'b0;
			#4 x=1'b1; y=1'b0; z=1'b0;
			#4 x=1'b1; y=1'b1; z=1'b0;
			#4 x=1'b0; y=1'b0; z=1'b1;
			#4 x=1'b0; y=1'b1; z=1'b1;
			#4 x=1'b1; y=1'b0; z=1'b1;
			#4 x=1'b1; y=1'b1; z=1'b1;
		end
endmodule