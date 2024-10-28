module mux2to1_gate(a,b,s,f);
	input a,b,s;
	output f;
	wire c,d,e;
	
	not n1(e,s);
	and a1(c,a,s);
	and a2(d,b,e);
	or o1(f,c,d);
endmodule
module testbench;
	reg a,b,s;					// input
	wire f;						// output
	mux2to1_gate mux_gate(a,b,s,f);
	initial
		begin
			$monitor(,$time,"a=%b,b=%b,s=%b f=%b",a,b,s,f);
			#0 a=1'b0;b=1'b1;	// 1'b0 means 1 bit value b0 is passed
			#2 s=1'b1;			// s is set to 1 after 2 time units
			#5 s=1'b0;			// s is set to 0 after 5 time units
			#10 a=1'b1;b=1'b0;
			#15 s=1'b1;
			#20 s=1'b0;
			#100 $finish;
		end
endmodule