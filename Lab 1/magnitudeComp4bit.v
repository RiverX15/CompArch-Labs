module magnitudeComp4bit_beh(a,b,c);
    input [3:0] a,b;
    output [2:0] c;
    reg c;
    always @(a or b)
        if (a<b) c=3'b100;
        else if (a==b) c=3'b010;
        else c=3'b001;
endmodule

module magnitudeComp4bit_df(a,b,c);
    input [3:0] a,b;
    output [2:0] c;
    assign c=(a<b)?(3'b100):((a==b)?(3'b010):(3'b001));
endmodule

// module testbench;
//     reg [3:0] a,b;
//     wire [2:0] c;
//     magnitudeComp4bit_df mag (a,b,c);
//     initial
//         begin
//             $monitor(,$time," a=%b, b=%b, c=%b", a,b,c);
//             #0 a=4'b0000; b=4'b0001;
//             #5 a=4'b0110; b=4'b0110;
//             #5 a=4'b1101; b=4'b1010;
//             #100 $finish;
//         end
// endmodule