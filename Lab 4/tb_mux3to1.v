`include "mux3to1_32bit.v"

module tb_mux2to1;
    reg [1:0] sel;
    reg [31:0] in1, in2, in3;
    wire [31:0] out;
    mux3to1_32bit mux(out, sel, in1, in2, in3);
    initial begin
        $monitor($time, " sel in1 in2 in3 out = %b %b %b %b\n\t\t%b", sel, in1, in2, in3, out);
        #0 sel=2'b00; in1=32'b01010101010101010101010101010101; in2=32'b10101010101010101010101010101010; in3=32'b11111111111111111111111111111111;
        #2 sel=2'b01;
        #2 sel=2'b10;
        #2 sel=2'b11;
        #2 in1=32'b00000000000000000000000000000000; in2=32'b10101010101010101010101010101010;
        #2 sel=2'b00;
        #2 sel=2'b01;
        #2 sel=2'b10;
        #2 sel=2'b11;
        #100 $finish;
    end
endmodule