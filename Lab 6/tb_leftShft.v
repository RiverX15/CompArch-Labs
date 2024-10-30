`include "leftShifter.v"

module tb_ls;
    reg [25:0] in;
    wire [27:0] out;
    leftShifter ls(out, in);
    initial begin
        $monitor("%0d\tin out = %b %b", $time, in, out);
        #0 in=26'b10101010101010101010101011;
        #2 in=26'b10101010101010101010111111;
        #100 $finish;
    end
endmodule