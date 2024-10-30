`include "signExtender.v"

module tb_se;
    reg [15:0] in;
    wire [31:0] out;
    signExtender se(out, in);
    initial begin
        $monitor("%0d\tin out = %b %b", $time, in, out);
        #0 in=16'h5134;
        #2 in=16'hAFED;
        #2 in=16'h89A2;
        #100 $finish;
    end
endmodule