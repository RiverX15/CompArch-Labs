module fullAdder1bit_df(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    assign sum=cin^(a^b), cout=(a&b)|(a&cin)|(b&cin);
endmodule

// module testbench;
//     reg a,b,cin;
//     wire sum,cout;
//     fullAdder1bit_df fa(a,b,cin,sum,cout);
//     initial
//         begin
//             $monitor(,$time," a, b, cin, sum, cout = %b %b %b %b %b", a,b,cin,sum,cout);
//             #0 a=1'b0; b=1'b0; cin=1'b0;
//             #5 a=1'b0; b=1'b0; cin=1'b1;
//             #5 a=1'b0; b=1'b1; cin=1'b0;
//             #5 a=1'b0; b=1'b1; cin=1'b1;
//             #5 a=1'b1; b=1'b0; cin=1'b0;
//             #5 a=1'b1; b=1'b0; cin=1'b1;
//             #5 a=1'b1; b=1'b1; cin=1'b0;
//             #5 a=1'b1; b=1'b1; cin=1'b1;
//             #100 $finish;
//         end
// endmodule