// INCORRECT

module d_ff(output q, input d, input clock, input reset);
    reg q;
    always @(posedge clock) begin
        if (reset) q<=1'b0;
        else q<=d;
    end
endmodule

module ControlLogic(output T2, output T1, output T0, input S, input Z, input X, input clock, input reset);
    wire sp, zp, xp, t0sp, t2z, t0s, t2xpzp, t1xp, t1x, t2zpx, dt0, dt1, dt2;
    not ns(sp, S);
    not nz(zp, Z);
    not nx(xp, X);
    and a1(t0sp, t0, sp);
    and a2(t2z, t2, z);
    and a3(t0s, t0, s);
    and a4(t2xpzp, t2, xp, zp);
    and a5(t1xp, t1, xp);
    and a6(t1x, t1, x);
    and a7(t2zpx, t2, zp, x);
    or o1(dt0, t0sp, t2z);
    or o2(dt1, t0s, t2xpzp, t1xp);
    or o3(dt2, t1x, t2zpx);
    d_ff dff0(T0, dt0, clock, reset);
    d_ff dff1(T1, dt1, clock, reset);
    d_ff dff2(T2, dt2, clock, reset);
endmodule

module TFF(output q, input t, input clock, input reset, input en);
    reg q;
    always @(posedge clock) begin
        if (reset) q<=1'b0;
        else
            if (en)
                if (t) q<=~q;
    end
endmodule

module COUNTER_4BIT(output [3:0] Q, input clock, input reset, input en);
    TFF tff0(Q[0], 1'b1, clock, reset, en);
    TFF tff1(Q[1], Q[0], clock, reset, en);
    TFF tff2(Q[2], Q[0]&Q[1], clock, reset, en);
    TFF tff3(Q[3], Q[0]&Q[1]&Q[2], clock, reset, en);
endmodule

module INTG(output [3:0] Q, output G, input S, input X, input clock, input reset);
    wire T0, T1, T2, Z;
    COUNTER_4BIT ctr(Q, clock, T0&S, (T1&X)|(T2&~Z&X));
    assign Z=Q[0]&Q[1]&Q[2]&Q[3];
    ControlLogic ctrl(T2, T1, T0, S, Z, X, clock, reset);
    d_ff dff(G, T2&Z, clock, 1'b0);
endmodule

`timescale 1ms/1us

module testbench;
    reg clock, reset, S, X;
    wire [3:0] Q;
    wire G;
    initial begin
        clock=0;
        reset=1;
    end
    always #0.5 clock=~clock;
    INTG int(Q, G, S, X, clock, reset);
    initial begin
        $monitor("%0d\t Q = %d\t G = %b", $time, Q, G);
        #2 reset=0; S=1; X=1;
        #50 $finish;
    end
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
    end
endmodule