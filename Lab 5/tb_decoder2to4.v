`include "decoder2to4.v"

module tb_decoder2to4;
    reg [1:0] sel;
    wire [3:0] out;
    decoder2to4 dcd(out, sel);
    initial begin
        $monitor($time, " sel out = %b %b ", sel, out);
        #0 sel=2'b00;
        #2 sel=2'b01;
        #2 sel=2'b10;
        #2 sel=2'b11;
        #100 $finish;
    end
endmodule