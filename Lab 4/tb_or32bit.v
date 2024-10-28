`include "or32bit.v"

module tb_and32bit;
    reg [31:0] in1, in2;
    wire [31:0] out;
    or32bit or32b(out, in1, in2);
    initial begin
        $monitor($time, " in1 in2 out = %b %b %b", in1, in2, out);
        #0 in1=32'b01010101010101010101010101010101; in2=32'b10101010101010101010101010101010;
        #2 in1=32'b01010101010101010101010101010101; in2=32'b01010101010101010101010101010101;
        #2 in1=32'b11111111111111110111111111111111; in2=32'b11111111111111111111110000000000;
        #100 $finish;
    end
endmodule