`include "mux4to1_32bit.v"

module tb_mux4to1;
    reg [1:0] sel;
    reg [31:0] in1, in2, in3, in4;
    wire [31:0] out;
    mux4to1_32bit mux(out, sel, in1, in2, in3, in4);
    initial begin
        $monitor($time, " in1 in2 in3 in4 sel out = %h %h %h %h %b %h", in1, in2, in3, in4, sel, out);
        #0 sel=2'b00; in1=32'hAFAFAFAF; in2=32'h0767a631; in3=32'hCDCDCDCD; in4=32'hFDFDEBEB;
        #2 sel=2'b01;
        #2 sel=2'b10;
        #2 sel=2'b11;
        #100 $finish;
    end
endmodule