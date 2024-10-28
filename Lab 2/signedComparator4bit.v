module signa(neg,A);
    input [3:0] A;
    output neg;
    reg neg;
    always @(A)
        neg=A[3];
endmodule

module compar(A,B,AltB,AeqB,AgtB);
    input [3:0] A, B;
    output AltB, AeqB, AgtB;
    reg AltB, AeqB, AgtB;
    wire signA, signB;
    signa sa(signA,A);
    signa sb(signB,B);
    always @(A or B) begin
        AltB=0;
        AeqB=0;
        AgtB=0;
        if (signA==1 && signB==0) begin
            AltB=1;
        end
        else if (signA==0 && signB==1) begin
            AgtB=1;
        end
        else if (A==B) begin
            AeqB=1;
        end
        else begin
            if (signA==1) begin
                if (A<B) begin
                    AltB=1;
                end
                else begin
                    AgtB=1;
                end
            end
            else begin
                if (A>B) begin
                    AltB=1;
                end
                else begin
                    AgtB=1;
                end
            end
        end
    end
endmodule

// module testbench;
//     reg [3:0] A,B;
//     wire AltB, AeqB, AgtB;
//     compar c1(A,B,AltB, AeqB, AgtB);
//     initial begin
//         $monitor(,$time, " A, B, AltB, AeqB, AgtB = %b %b %b %b %b", A,B,AltB, AeqB, AgtB);
//         #0 A=4'b0000; B=4'b0000;
//         #5 A=4'b1000; B=4'b1011;
//         #5 A=4'b0010; B=4'b0111;
//         #5 A=4'b0101; B=4'b1111;
//         #100 $finish;
//     end
// endmodule