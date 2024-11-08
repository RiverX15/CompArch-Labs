// INCORRECT

`timescale 1ms/1us

module d_ff(output q, input d, input clock);
    reg q;
    always @(posedge clock) begin
        q<=d;
    end
endmodule

module ControlLogic(output [2:0] T, input S, input Z, input X, input clock);
    wire sp, xp, zp, t0sp, t2z, t0s, t2xpzp, t1xp, t1x, t2zpx, dt0, dt1, dt2;
    not n1(sp, S);
    not n2(xp, X);
    not n3(zp, Z);
    and a1(t0sp, T[0], sp);
    and a2(t2z, T[2], Z);
    and a3(t0s, T[0], S);
    and a4(t2xpzp, T[2], xp, zp);
    and a5(t1xp, T[1], xp);
    and a6(t1x, T[1], X);
    and a7(t2zpx, T[2], zp, X);
    or o1(dt0, t0sp, t2z);
    or o2(dt1, t0s, t2xpzp, t1xp);
    or o3(dt2, t1x, t2zpx);
    d_ff d0(T[0], dt0, clock);
    d_ff d1(T[1], dt1, clock);
    d_ff d2(T[2], dt2, clock);
endmodule

module TFF(output q, input t, input clock, input clear);
    reg q;
    always @(posedge clock) begin
        if (clear) q<=0;
        else q<=q^t;
    end
endmodule

module COUNTER_4BIT(output [3:0] Q, input clock, input clear);
    TFF t0(Q[0], 1'b1, clock, clear);
    TFF t1(Q[1], Q[0], clock, clear);
    TFF t2(Q[2], Q[0]&Q[1], clock, clear);
    TFF t3(Q[3], Q[0]&Q[1]&Q[2], clock, clear);
endmodule

module INTG(output [3:0] Q, output G, input S, input X, input clock);
    wire [2:0] T;
    COUNTER_4BIT ctr(Q, clock, T[0]&S);
    wire Z;
    assign Z=Q[0]&Q[1]&Q[2]&Q[3];
    ControlLogic ctrl(T, S, Z, X, clock);
    d_ff dff(G, Z&T[2], clock);
endmodule

module testbench;
    reg S, X, clock;
    wire [3:0] Q;
    wire G;
    initial clock=0;
    always #0.5 clock=~clock;
    INTG int(Q, G, S, X, clock);
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        $monitor("%0d\t S = %b\t X = %b\t clock = %b\t Q = %d\t G = %b", $time, S, X, clock, 
                Q, G);
        #0 S=1; X=1;
        #100 $finish;
    end
endmodule