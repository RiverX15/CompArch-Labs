module MUX_16x1(output [8:0] out, input [3:0] sel);
    reg [8:0] mem[0:15];
    initial begin
        mem[0]=0*25;
        mem[1]=1*25;
        mem[2]=2*25;
        mem[3]=3*25;
        mem[4]=4*25;
        mem[5]=5*25;
        mem[6]=6*25;
        mem[7]=7*25;
        mem[8]=8*25;
        mem[9]=9*25;
        mem[10]=10*25;
        mem[11]=11*25;
        mem[12]=12*25;
        mem[13]=13*25;
        mem[14]=14*25;
        mem[15]=15*25;
    end
    assign out=mem[sel];
endmodule

module Adder_Register(output [12:0] Y, input [8:0] muxOut, input clock, input Acc_rst1, input Acc_rst2);
    reg [12:0] acc;
    initial acc=13'b0000000000000;
    always @(posedge Acc_rst2 or negedge Acc_rst2) acc<=13'b0000000000000;
    always @(posedge clock) begin
        if (Acc_rst1) acc<=acc+muxOut;
    end
    assign Y=acc;
endmodule

module DFF(output q, input d, input clock, input reset);
    reg q;
    always @(posedge clock or reset) begin
        if (reset) q=1'b1;
        else q=d;
    end
endmodule

module ACC_RST(output Acc_rst1, output Acc_rst2, input clock, input reset);
    wire [3:0] Q;
    DFF d0(Q[0], ~Q[0], clock, reset);
    DFF d1(Q[1], ~Q[1], Q[0], reset);
    DFF d2(Q[2], ~Q[2], Q[1], reset);
    DFF d3(Q[3], ~Q[3], Q[2], reset);
    assign Acc_rst1=Q[2], Acc_rst2=Q[3];
endmodule

module INTG(output [12:0] Y, input [3:0] X, input clock, input reset);
    wire [8:0] muxOut;
    MUX_16x1 mux(muxOut, X);
    wire Acc_rst1, Acc_rst2;
    ACC_RST accr(Acc_rst1, Acc_rst2, clock, reset);
    Adder_Register addr(Y, muxOut, clock, Acc_rst1, Acc_rst2);
endmodule

module testbench;
    reg [3:0] X;
    reg clock, reset;
    wire [12:0] Y;
    INTG int(Y, X, clock, reset);
    initial begin
        clock=0;
        reset=1;
        X=4'd0;
    end
    always #1 clock=~clock;
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        $monitor("%0d\t X = %d\t clock = %b\t reset = %b\t Y = %d", $time, X, clock, reset, Y);
        #2 reset=0;
        #1 X=4'd10;
        #2 X=4'd5;
        #2 X=4'd12;
        #2 X=4'd1;
        #2 X=4'd13;
        #2 X=4'd7;
        #2 X=4'd9;
        #2 X=4'd2;
        #2 X=4'd11;
        #2 X=4'd5;
        #2 X=4'd4;
        #2 X=4'd2;
        #100 $finish;
    end
endmodule