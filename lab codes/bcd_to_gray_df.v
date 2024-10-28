module bcd_to_gray_df(b3,b2,b1,b0,d3,d2,d1,d0);
	input b3,b2,b1,b0;
	output d3,d2,d1,d0;
	assign d3=b3;
	assign d2=b3|b2;
	assign d1=(~b2&b1)|(~b1&b2);
	assign d0=(~b1&b0)|(~b0&b1);
endmodule