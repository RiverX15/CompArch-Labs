module MUX_2x1(output out, input in1, input in2, input sel);
    assign out=(sel)?(in2):(in1);
endmodule

module MUX_8x1(output out, input [7:0] in, input [2:0] sel);
    assign out=in[sel];
endmodule

module MUX_ARRAY(output [0:7] out, input [7:0] in1, input [7:0] in2, input [7:0] sel);
    genvar j;
    generate for (j=0; j<8; j=j+1) begin
        MUX_2x1 mux(out[j], in1[j], in2[j], sel[j]);
    end
    endgenerate
endmodule

module COUNTER_3BIT(output [2:0] out, input clock, input clear);
    reg out;
    always @(posedge clock) begin
        out=out+1;
    end
    always @(clear) begin
        if (clear) out=3'b000;
    end
endmodule

// module tb_ctr;
//     reg clock, clear;
//     wire [2:0] out;
//     initial clock=0;
//     always #2 clock=~clock;
//     COUNTER_3BIT ctr(out, clock, clear);
//     initial begin
//         $monitor("%0d\tclock = %b\tclear = %b\tout = %d", $time, clock, clear, out);
//         #0 clear=1;
//         #5 clear=0;
//         #100 $finish;
//     end
// endmodule

module DECODER(output [7:0] out, input [2:0] in, input en);
    reg [7:0] out;
    always @(*) begin
        out=8'h00;
        if (en) out[in]=1;
    end
endmodule

module MEMORY(output [7:0] out, input [2:0] in);
    reg [7:0] mem[0:7];
    initial begin
        mem[0]=8'h01;
        mem[1]=8'h03;
        mem[2]=8'h07;
        mem[3]=8'h0F;
        mem[4]=8'h1F;
        mem[5]=8'h3F;
        mem[6]=8'h7F;
        mem[7]=8'hFF;
    end
    reg [7:0] out;
    always @(*) begin
        out=mem[in];
    end
endmodule

module TOP_MODULE(output out, input [2:0] addr, input clock, input clear, input en);
    wire [2:0] Q;
    COUNTER_3BIT ctr(Q, clock, clear);
    wire [7:0] B;
    DECODER dcdr(B, Q, en);
    wire [7:0] E;
    wire [7:0] G;
    MEMORY mem(G, addr);
    MUX_ARRAY muxArr(E, 8'h00, B, G);
    MUX_8x1 mux(out, E, Q);
endmodule

`timescale 1ms/1ns

module testbench;
    reg [2:0] addr;
    reg clock, clear, en;
    wire out;
    initial clock=0;
    always #0.5 clock=~clock;
    initial addr=3'b000;
    always #8 addr=addr+1;
    TOP_MODULE tp(out, addr, clock, clear, en);
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        $monitor("%0d\taddr = %d\tclock = %b\tclear = %b\ten = %b\tout = %b", $time, addr, 
                clock, clear, en, out);
        #0 clear=1; en=1;
        #1 clear=0; addr=3'b000;
        #100 $finish;
    end
endmodule