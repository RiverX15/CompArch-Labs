module dff_sync_clear(d, clearb, clock, q);
	input d, clearb, clock;
	output q;
	reg q;
	always @ (posedge clock)
	begin
		if (!clearb) q <= 1'b0;
		else q <= d;
	end
endmodule

module dff_async_clear(d, clearb, clock, q);
	input d, clearb, clock;
	output q;
	reg q;
	always @ (negedge clearb or posedge clock)
	begin
		if (!clearb) q <= 1'b0;
		else q <= d;
	end
endmodule

module Testing;
	reg d, clk, rst;
	wire q;
	dff_sync_clear dff (d, rst, clk, q); // Or dff_async_clear dff (d, clk,	rst, q);
	//Always at rising edge of clock display the signals
	
	
	//Module to generate clock with period 10 time units
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
			$monitor("d=%b, clk=%b, rst=%b, q=%b\n", d, clk, rst, q); // PREFER $monitor over $display
			d=0; rst=1;
			#20
			d=1; rst=0;
			#20
			d=1; rst=1;
			#20
			d=0; rst=0;
			#20
			$finish;
		end
endmodule