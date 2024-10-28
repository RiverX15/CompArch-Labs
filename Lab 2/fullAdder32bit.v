`include "decoder3to8.v"

module fadder8bit(sum, cout, x, y, cin);
    input [7:0] x,y;
    input cin;
    output [7:0] sum;
    output cout;
    wire [6:0] tempcout;
    FADDER f1(sum[0], tempcout[0], x[0], y[0], cin);
    FADDER f2(sum[1], tempcout[1], x[1], y[1], tempcout[0]);
    FADDER f3(sum[2], tempcout[2], x[2], y[2], tempcout[1]);
    FADDER f4(sum[3], tempcout[3], x[3], y[3], tempcout[2]);
    FADDER f5(sum[4], tempcout[4], x[4], y[4], tempcout[3]);
    FADDER f6(sum[5], tempcout[5], x[5], y[5], tempcout[4]);
    FADDER f7(sum[6], tempcout[6], x[6], y[6], tempcout[5]);
    FADDER f8(sum[7], cout, x[7], y[7], tempcout[6]);
endmodule

module fadder32bit(sum, cout, x, y, cin);
    input [31:0] x,y;
    input cin;
    output [31:0] sum;
    output cout;
    wire [2:0] tempcout;
    fadder8bit f1(sum[7:0], tempcout[0], x[7:0], y[7:0], cin);
    fadder8bit f2(sum[15:8], tempcout[1], x[15:8], y[15:8], tempcout[0]);
    fadder8bit f3(sum[23:16], tempcout[2], x[23:16], y[23:16], tempcout[1]);
    fadder8bit f4(sum[31:24], cout, x[31:24], y[31:24], tempcout[2]);
endmodule

// module testbench;
//     reg [7:0] x,y;
//     reg cin;
//     wire [7:0] sum;
//     wire cout;
//     fadder8bit f1(sum, cout, x, y, cin);
//     initial
//         begin
//             $monitor(,$time, " x, y, cin, sum, cout = %b %b %b %b %b", x,y,cin,sum,cout);
//             #0 x=8'b00000000; y=8'b00000000; cin=1'b0;
//             #5 x=8'b01101001; y=8'b00101001; cin=1'b0;
//             #5 x=8'b01101001; y=8'b00101001; cin=1'b1;
//             #5 x=8'b01101101; y=8'b11101001; cin=1'b0;
//             #5 x=8'b11111111; y=8'b00000000; cin=1'b1;
//             #5 x=8'b11111111; y=8'b00000000; cin=1'b0;
//         end
// endmodule

// module testbench;
//     reg [31:0] x,y;
//     reg cin;
//     wire [31:0] sum;
//     wire cout;
//     fadder32bit f1(sum, cout, x, y, cin);
//     initial
//         begin
//             $monitor(,$time, " x, y, cin, sum, cout = %b %b %b %b %b", x,y,cin,sum,cout);
//             #0 x=32'b00000000000000000000000000000000; y=32'b00000000000000000000000000000000; cin=1'b0;
//             #5 x=32'b10000000100000000000000001000100; y=32'b00001000000000010000010000000100; cin=1'b0;
//             #5 x=32'b10000000100000000000000001000100; y=32'b00001000000000010000010000000100; cin=1'b1;
//             #5 x=32'b10010000100100000010000001000100; y=32'b01001000000100010000010000000100; cin=1'b0;
//             #5 x=32'b10010000100100000010000001000100; y=32'b01001000000100010000010000000100; cin=1'b1;
//             #5 x=32'b11010000100100000010000001000100; y=32'b01001001000100010100010001000100; cin=1'b0;
//             #5 x=32'b01010000100100000010000001000100; y=32'b01001001000100010100010001000100; cin=1'b0;
//             #5 x=32'b11111111111111111111111111111111; y=32'b11111111111111111111111111111111; cin=1'b1;
//             #5 x=32'b11111111111111111111111111111111; y=32'b11111111111111111111111111111111; cin=1'b0;
//             #100 $finish;
//         end
// endmodule