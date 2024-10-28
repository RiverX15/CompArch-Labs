module bcdToGray_gate(b3,b2,b1,b0,d3,d2,d1,d0);
    input b3,b2,b1,b0;
    output d3,d2,d1,d0;
    wire nb3, nb2, nb1, nb0, w1, w2, w3, w4;
    not n1(nb3,b3);
    not n2(nb2,b2);
    not n3(nb1,b1);
    not n4(nb0,b0);
    and a1(w1, nb2, b1);
    and a2(w2, b2, nb1);
    and a3(w3, nb1, b0);
    and a4(w4, b1, nb0);
    
    or o1(d3,b3,b3);
    or o2(d2,b3,b2);
    or o3(d1, w1, w2);
    or o4(d0, w3, w4);
endmodule

module bcdToGray_df(b3,b2,b1,b0,d3,d2,d1,d0);
    input b3,b2,b1,b0;
    output d3,d2,d1,d0;
    assign d3=b3, d2=b3|b2, d1=(~b2&b1)|(b2&~b1), d0=(~b1&b0)|(b1&~b0);
endmodule

// module testbench;
//     reg b3,b2,b1,b0;
//     wire d3,d2,d1,d0;
//     bcdToGray_df bcd (b3,b2,b1,b0,d3,d2,d1,d0);
//     initial
//         begin
//             $monitor(,$time," b3 b2 b1 b0 = %b %b %b %b, d3 d2 d1 d0 = %b %b %b %b", b3,b2,b1,b0,d3,d2,d1,d0);
//             #0 b3=1'b0; b2=1'b0; b1=1'b0; b0=1'b0;
//             #5 b3=1'b0; b2=1'b0; b1=1'b0; b0=1'b1;
//             #5 b3=1'b0; b2=1'b0; b1=1'b1; b0=1'b0;
//             #5 b3=1'b0; b2=1'b0; b1=1'b1; b0=1'b1;
//             #5 b3=1'b0; b2=1'b1; b1=1'b0; b0=1'b0;
//             #5 b3=1'b0; b2=1'b1; b1=1'b0; b0=1'b1;
//             #5 b3=1'b0; b2=1'b1; b1=1'b1; b0=1'b0;
//             #5 b3=1'b0; b2=1'b1; b1=1'b1; b0=1'b1;
//             #5 b3=1'b1; b2=1'b0; b1=1'b0; b0=1'b0;
//             #5 b3=1'b1; b2=1'b0; b1=1'b0; b0=1'b1;
//             #100 $finish;
//         end
// endmodule