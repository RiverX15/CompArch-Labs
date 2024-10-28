`include "mux2to1_32bit.v"

module tb_mux2to1;
    reg sel;
    reg [31:0] in1, in2;
    wire [31:0] out;
    mux2to1_32bit mux(out, sel, in1, in2);
    initial begin
        $monitor($time, " sel in1 in2 out = %b %b %b %b", sel, in1, in2, out);
        #0 sel=1'b0; in1=32'b01010101010101010101010101010101; in2=32'b10101010101010101010101010101010;
        #2 sel=1'b1;
        #2 sel=1'b0;
        #2 in1=32'b11010001010101011101010101010101; in2=32'b10101010101010101010101010101010;
        #2 sel=1'b1;
        #2 sel=1'b1;
        #2 sel=1'b0;
        #100 $finish;
    end
endmodule