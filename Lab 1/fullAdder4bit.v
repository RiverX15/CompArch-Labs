`include "fullAdder1bit.v"

module fullAdder4bit(a,b,cin,sum,cout);
    input [3:0] a,b;
    input cin;
    output [3:0] sum;
    output cout;
    wire [2:0] tempcout;
    fullAdder1bit_df f1(a[0], b[0], cin, sum[0], tempcout[0]);
    fullAdder1bit_df f2(a[1], b[1], tempcout[0], sum[1], tempcout[1]);
    fullAdder1bit_df f3(a[2], b[2], tempcout[1], sum[2], tempcout[2]);
    fullAdder1bit_df f4(a[3], b[3], tempcout[2], sum[3], cout);
endmodule

// module testbench;
//     reg [3:0] a,b;
//     reg cin;
//     wire [3:0] sum;
//     wire cout;
//     fullAdder4bit fa(a,b,cin,sum,cout);
//     initial
//         begin
//             $monitor(,$time," a, b, cin, sum, cout = %b %b %b %b %b", a,b,cin,sum,cout);
//             #0 a=4'b0000; b=4'b0000; cin=1'b0;
//             #5 a=4'b0010; b=4'b1101; cin=1'b0;
//             #5 a=4'b0010; b=4'b1101; cin=1'b1;
//             #5 a=4'b0010; b=4'b1111; cin=1'b0;
//             #5 a=4'b1001; b=4'b0001; cin=1'b0;
//             #100 $finish;
//         end
// endmodule