module jkff(j, k, clock, q);
	input j, k, clock;
	output q;
	reg q;
	always @ (posedge clock)
		begin
			q <= (j&~q)|(~k&q);
		end
endmodule

module Testbench;
	reg j, k, clk;
	wire q;
	jkff jk_ff (j, k, clk, q);
	initial
		begin
			forever
				begin
					clk=0;
					#5
					clk=1;
					#5
					clk=0;
				end
		end
	initial
		begin
			$dumpfile("jk_flip_flop.vcd");
			$dumpvars();
			$monitor("j=%b k=%b clk=%b q=%b\n", j, k, clk, q);
			j=0; k=0;
			#20
			j=0; k=1;
			#20
			j=1; k=0;
			#20
			j=1; k=1;
			#20
			j=0; k=0;
			#20
			j=0; k=1;
			#20
			j=1; k=0;
			#20
			j=1; k=1;
			#20
			$finish;
		end
endmodule