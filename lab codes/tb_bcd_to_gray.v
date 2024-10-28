module bcd_to_gray_gate(b3,b2,b1,b0,d3,d2,d1,d0);
	input b3,b2,b1,b0;
	output d3,d2,d1,d0;
	
	assign d3=b3;		// d3
	or o1(d2,b2,b3);	// d2
	wire w1;
	not n1(w1,b2);		// w1=~b2
	wire w2;
	and a1(w2,w1,b1);	// w2=(~b2)^(b1)
	wire w3;
	not n2(w3,b1);		// w3=~b1
	wire w4;
	and a2(w4,b2,w3);	// w4=(~b1)^(b2)
	or o2(d1,w2,w4);	// d1
	wire w5;
	and a3(w5,w3,b0);
	wire w6;
	not n3(w6,b0);
	wire w7;
	and a4(w7,w6,b1);
	or o3(d0,w7,w5);
endmodule
module bcd_to_gray_df(b3,b2,b1,b0,d3,d2,d1,d0);
	input b3,b2,b1,b0;
	output d3,d2,d1,d0;
	assign d3=b3;
	assign d2=b3|b2;
	assign d1=(~b2&b1)|(~b1&b2);
	assign d0=(~b1&b0)|(~b0&b1);
endmodule
module testbench;
	reg b3,b2,b1,b0;
	wire d3,d2,d1,d0;
	bcd_to_gray_df bcd2gray(b3,b2,b1,b0,d3,d2,d1,d0);
	initial
		begin
			$monitor(,$time," b3=%b b2=%b b1=%b b0=%b d3=%b d2=%b d1=%b d0=%b",b3,b2,b1,b0,d3,d2,d1,d0);
			#0 b3=1'b0;b2=1'b0;b1=1'b0;b0=1'b0;
			#5 b3=1'b0;b2=1'b0;b1=1'b0;b0=1'b1;
			#5 b3=1'b0;b2=1'b0;b1=1'b1;b0=1'b0;
			#5 b3=1'b0;b2=1'b0;b1=1'b1;b0=1'b1;
			#5 b3=1'b0;b2=1'b1;b1=1'b0;b0=1'b0;
			#5 b3=1'b0;b2=1'b1;b1=1'b0;b0=1'b1;
			#5 b3=1'b0;b2=1'b1;b1=1'b1;b0=1'b0;
			#5 b3=1'b0;b2=1'b1;b1=1'b1;b0=1'b1;
			#5 b3=1'b1;b2=1'b0;b1=1'b0;b0=1'b0;
			#5 b3=1'b1;b2=1'b0;b1=1'b0;b0=1'b1;
			#100 $finish;
		end
endmodule