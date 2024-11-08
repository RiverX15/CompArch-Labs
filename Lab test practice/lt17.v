module MUX_SMALL(output out, input in1, input in2, input sel);
    assign out=sel?in2:in1;
endmodule

module MUX_BIG(output out, input [7:0] in, input [2:0] sel);
    wire s01, s23, s45, s67;
    MUX_SMALL m1(s01, in[0], in[1], sel[0]);
    MUX_SMALL m2(s23, in[2], in[3], sel[0]);
    MUX_SMALL m3(s45, in[4], in[5], sel[0]);
    MUX_SMALL m4(s67, in[6], in[7], sel[0]);
    wire s0123, s4567;
    MUX_SMALL m5(s0123, s01, s23, sel[1]);
    MUX_SMALL m6(s4567, s45, s67, sel[1]);
    MUX_SMALL m7(out, s0123, s4567, sel[2]);
endmodule

module TFF(output q, input t, input clock, input reset);
    reg q;
    always @(posedge clock or negedge reset) begin
        if (!reset) q<=0;
        else
            if (!t) q<=q;
            else q<=~q;
    end
endmodule

// module tb_tff;
//     reg t, clock, reset;
//     wire q;
//     initial clock=0;
//     always #2 clock=~clock;
//     TFF tf(q, t, clock, reset);
//     initial begin
//         $monitor("%0d\t t = %b\t clock = %b\t reset = %b\t q = %b", $time, t, clock, reset, q);
//         #0 reset=0;
//         #5 reset=1; t=0;
//         #5 t=1;
//         #5 reset=0;
//         #100 $finish;
//     end
// endmodule

module COUNTER_4BIT(output [3:0] Q, input clock, input reset);
    TFF t0(Q[0], 1'b1, clock, reset);
    TFF t1(Q[1], Q[0], clock, reset);
    TFF t2(Q[2], Q[0]&Q[1], clock, reset);
    TFF t3(Q[3], Q[0]&Q[1]&Q[2], clock, reset);
endmodule

// module tb_ctr4;
//     reg clock, reset;
//     wire [3:0] Q;
//     COUNTER_4BIT ctr4(Q, clock, reset);
//     initial clock=0;
//     always #2 clock=~clock;
//     initial begin
//         $monitor("%0d\t clock = %b\t reset = %b\t Q = %b", $time, clock, reset, Q);
//         #0 reset=0;
//         #5 reset=1;
//         #100 $finish;
//     end
// endmodule

module COUNTER_3BIT(output [2:0] Q, input clock, input reset);
    TFF t0(Q[0], 1'b1, clock, reset);
    TFF t1(Q[1], Q[0], clock, reset);
    TFF t2(Q[2], Q[0]&Q[1], clock, reset);
endmodule

module MEMORY(output [7:0] D, input [3:0] A);
    reg [7:0] mem[0:15];
    initial begin
        mem[0]=8'hCC;
        mem[1]=8'hAA;
        mem[2]=8'hCC;
        mem[3]=8'hAA;
        mem[4]=8'hCC;
        mem[5]=8'hAA;
        mem[6]=8'hCC;
        mem[7]=8'hAA;
        mem[8]=8'hCC;
        mem[9]=8'hAA;
        mem[10]=8'hCC;
        mem[11]=8'hAA;
        mem[12]=8'hCC;
        mem[13]=8'hAA;
        mem[14]=8'hCC;
        mem[15]=8'hAA;
    end
    assign D=mem[A];
endmodule

module INTG(output out, input clock, input clear);
    wire [2:0] Q;
    COUNTER_3BIT ctr3b(Q, clock, clear);
    wire [3:0] A;
    COUNTER_4BIT ctr4b(A, Q[0]&Q[1]&Q[2], clear);
    wire [7:0] D;
    MEMORY mem(D, A);
    MUX_BIG mux(out, D, Q);
endmodule

`timescale 1ms/1ns

module testbench;
    reg clock, clear;
    wire out;
    initial clock=0;
    always #0.5 clock=~clock;
    INTG intg(out, clock, clear);
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        // $monitor("%0d\t clock = %b\t clear = %b\t out = %b", $time, clock, clear, out);
        #0 clear=0;
        #5 clear=1;
        #1000 $finish;
    end
endmodule