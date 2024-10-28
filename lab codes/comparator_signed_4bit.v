module signa(neg, A);
	input [3:0] A;
	output neg;
	reg neg;
	always@(A)
		if (A[3]==1)
			begin
				neg=1;
			end
		else
			begin
				neg=0;
			end
endmodule

module compar(A, B, signA, signB, CMP1, CMP2, CMP3);
	input [3:0] A, B;
	output signA, signB, CMP1, CMP2, CMP3;
	reg CMP1, CMP2, CMP3;
	signa forA(signA, A);
	signa forB(signB, B);
	always @ (A or B or signA or signB)
		if (signA==1 && signB==0)
			begin
				CMP1=0;
				CMP2=0;
				CMP3=1;
			end
		else if (signA==0 && signB==1)
			begin
				CMP1=1;
				CMP2=0;
				CMP3=0;
			end
		else if (A>B)
			begin
				CMP1=1;
				CMP2=0;
				CMP3=0;
			end
		else if (A==B)
			begin
				CMP1=0;
				CMP2=1;
				CMP3=0;
			end
		else
			begin
				CMP1=0;
				CMP2=0;
				CMP3=1;
			end
endmodule