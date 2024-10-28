module shiftReg(EN, in, CLK, Q);
    parameter n=4;
    input EN, in, CLK;
    output [n-1:0] Q;
    reg [n-1:0] Q;
    initial Q=4'd0;
    always @(posedge CLK) begin
        if (EN) Q={in,Q[n-1:1]};
    end
endmodule

// module testbench;
//     parameter n=4;
//     reg EN, in, CLK;
//     wire [n-1:0] Q;
//     shiftreg sr(EN, in, CLK, Q);
//     initial begin
//         CLK=0;
//     end
//     always 
//     #2 CLK=~CLK;
//     initial
//     $monitor($time, " EN=%b, in=%b, CLK=%b, Q=%b\n", EN, in, CLK, Q);
//     initial
//     begin
//         $dumpfile("output.vcd");
//         $dumpvars;
//         in=0;
//         EN=0;
//         #4 in=1; EN=1;
//         #4 in=1; EN=0;
//         #4 in=0; EN=1;
//         #5 $finish;
//     end
// endmodule