module jkff(j, k, clock, q);
	input j, k, clock;
	output q;
	reg q;
	always @ (posedge clock)
		begin
			q <= (j&~q)|(~k&q);
		end
endmodule

module 4bit_synchronous_counter(EN, CLK, Q);
	parameter n=4;
	input CLK;
	output [n-1:0] Q;
	reg [n-1:0] Q;
	
	initial
		Q=
	