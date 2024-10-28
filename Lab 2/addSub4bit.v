// INCOMPLETE

module fullAdder1bit_beh(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    reg sum,cout;
    always @(a or b or cin) begin
        sum=a^b^cin;
        cout=(a&b)|((a|b)&cin);
    end
endmodule

// module testbench;
//     reg a,b,cin;
//     wire sum,cout;
//     fullAdder1bit_beh fa(a,b,cin,sum,cout);
//     initial begin
//         $monitor(,$time," a, b, cin, sum, cout = %b %b %b %b %b", a,b,cin,sum,cout);
//         #0 a=1'b0; b=1'b0; cin=1'b0;
//         #5 a=1'b0; b=1'b0; cin=1'b1;
//         #5 a=1'b0; b=1'b1; cin=1'b0;
//         #5 a=1'b0; b=1'b1; cin=1'b1;
//         #5 a=1'b1; b=1'b0; cin=1'b0;
//         #5 a=1'b1; b=1'b0; cin=1'b1;
//         #5 a=1'b1; b=1'b1; cin=1'b0;
//         #5 a=1'b1; b=1'b1; cin=1'b1;
//         #100 $finish;
//     end
// endmodule

module addSub4bit(sum,cout,v,a,b,m);
    input [3:0] a,b;
    input m;
    output [3:0] sum;
    output cout, v;
    wire [3:0] nb;
    assign nb[0]=b[0]^m;
    assign nb[1]=b[1]^m;
    assign nb[2]=b[2]^m;
    assign nb[3]=b[3]^m;
    wire [2:0] tempcout;
    fullAdder1bit_beh f1(a[0],nb[0],m,sum[0],tempcout[0]);
    fullAdder1bit_beh f2(a[1],nb[1],tempcout[0],sum[1],tempcout[1]);
    fullAdder1bit_beh f3(a[2],nb[2],tempcout[1],sum[2],tempcout[2]);
    fullAdder1bit_beh f4(a[3],nb[3],tempcout[2],sum[3],cout);
    assign v=tempcout[2]^cout;
endmodule

module testbench;
    reg [3:0] a,b;
    reg m;
    wire [3:0] sum;
    wire cout,v;
    addSub4bit as (sum,cout,v,a,b,m);
    initial
        begin
            $monitor(,$time," a, b, m, sum, cout, v = %b %b %b %b %b %b", a,b,m,sum,cout,v);
            #0 a=4'b0000; b=4'b0000; m=1'b0;
            #5 a=4'b0010; b=4'b1101; m=1'b0;
            #5 a=4'b0010; b=4'b1101; m=1'b0;
            #5 a=4'b0010; b=4'b1111; m=1'b0;
            #5 a=4'b1001; b=4'b0001; m=1'b0;
            #5 a=4'b0000; b=4'b0000; m=1'b1;
            #5 a=4'b0010; b=4'b1101; m=1'b1;
            #5 a=4'b0010; b=4'b1101; m=1'b1;
            #5 a=4'b0010; b=4'b1111; m=1'b1;
            #5 a=4'b1001; b=4'b0001; m=1'b1;
            #5 a=4'b0001; b=4'b0001; m=1'b1;
            #100 $finish;
        end
endmodule