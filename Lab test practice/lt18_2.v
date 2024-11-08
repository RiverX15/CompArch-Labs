// INCORRECT

module d_ff(output q, input d, input clock, input reset);
    reg q;
    always @(posedge clock) begin
        if (reset) q<=0;
        else q<=d;
    end
endmodule

module ControlLogic(output [2:0] T, input S, input Z, input X, input CLK);
    wire S_n, Z_n, X_n;
    not n1(S_n, S);
    not n2(Z_n, Z);
    not n3(X_n, X);
    wire prods[0:6];
    and a1(prods[0], T[0], S_n);
    and a2(prods[1], T[2], Z);
    and a3(prods[2], T[0], S);
    and a4(prods[3], T[2], X_n, Z_n);
    and a5(prods[4], T[1], X_n);
    and a6(prods[5], T[1], X);
    and a7(prods[6], T[2], Z_n, X);
    wire dt[0:2];
    or o1(dt[0], prods[0], prods[1]);
    or o2(dt[1], prods[2], prods[3], prods[4]);
    or o3(dt[2], prods[5], prods[6]);
    d_ff d0(T[0], dt[0], CLK, 1'b0);
    d_ff d1(T[1], dt[1], CLK, 1'b0);
    d_ff d2(T[2], dt[2], CLK, 1'b0);
endmodule

module TFF(output q, input t, input clock, input reset);
    reg q;
    always @(posedge clock) begin
        if (reset) q<=0;
        else
            case(t)
            1'b0: q<=q;
            1'b1: q<=~q;
            endcase
    end
endmodule

module COUNTER_4BIT(output [3:0] Q, input clock, input reset, input en);
    assign clk=clock&en;
    TFF t0(Q[0], 1'b1, clk, reset);
    TFF t1(Q[1], Q[0], clk, reset);
    TFF t2(Q[2], Q[0]&Q[1], clk, reset);
    TFF t3(Q[3], Q[0]&Q[1]&Q[2], clk, reset);
endmodule

module INTG(output [3:0] Q, output G, input S, input X, input clock);
    wire reset, en, Z;
    wire [2:0] T;
    assign reset=T[0]&S;
    assign en=(T[1]&X)|(T[2]&~Z&X);
    assign Z=Q[0]&Q[1]&Q[2]&Q[3];
    COUNTER_4BIT ctr(Q, clock, reset, en);
    ControlLogic ctrl(T, S, Z, X, clock);
    d_ff df(G, T[2]&Z, clock, reset);
endmodule

`timescale 1ms/1ns

module testbench;
    reg S, X, clock;
    wire [3:0] Q;
    wire G;
    initial clock=0;
    always #0.5 clock=~clock;
    INTG int(Q, G, S, X, clock);
    initial begin
        $monitor("%0d\t S = %b\t X = %b\t clock = %b\t Q = %b\t G = %b\t", $time, S, X, clock, Q, G);
        #0 S=1; X=1;
        #50 $finish;
    end
endmodule