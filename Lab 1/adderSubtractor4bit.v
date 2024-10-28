`include "fullAdder4bit.v"
`include "mux2to1.v"

module adderSubtractor4bit(a,b,cin,sel,sum,cout);
    input [3:0] a,b;
    input cin,sel;
    output [3:0] sum;
    output cout;
    wire [3:0] nb;
    wire ncin;
    assign nb[0]=b[0]^sel;
    assign nb[1]=b[1]^sel;
    assign nb[2]=b[2]^sel;
    assign nb[3]=b[3]^sel;
    assign ncin=cin|sel;
    fullAdder4bit fa(a,nb,ncin,sum,cout);
endmodule

// module testbench;
//     reg [3:0] a,b;
//     reg cin, sel;
//     wire [3:0] sum;
//     wire cout;
//     adderSubtractor4bit as (a,b,cin,sel,sum,cout);
//     initial
//         begin
//             $monitor(,$time," a, b, cin, sel, sum, cout = %b %b %b %b %b %b", a,b,cin,sel,sum,cout);
//             #0 a=4'b0000; b=4'b0000; cin=1'b0; sel=1'b0;
//             #5 a=4'b0010; b=4'b1101; cin=1'b0; sel=1'b0;
//             #5 a=4'b0010; b=4'b1101; cin=1'b1; sel=1'b0;
//             #5 a=4'b0010; b=4'b1111; cin=1'b0; sel=1'b0;
//             #5 a=4'b1001; b=4'b0001; cin=1'b0; sel=1'b0;
//             #5 a=4'b0000; b=4'b0000; cin=1'b0; sel=1'b1;
//             #5 a=4'b0010; b=4'b1101; cin=1'b0; sel=1'b1;
//             #5 a=4'b0010; b=4'b1101; cin=1'b1; sel=1'b1;
//             #5 a=4'b0010; b=4'b1111; cin=1'b0; sel=1'b1;
//             #5 a=4'b1001; b=4'b0001; cin=1'b0; sel=1'b1;
//             #100 $finish;
//         end
// endmodule