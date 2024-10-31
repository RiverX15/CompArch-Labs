`include "evenParityGenerator.v"

module tb_epg;
    reg [3:0] in;
    wire [4:0] out;
    evenParityGenerator epg(out, in);
    initial begin
        $monitor("%0d\in out = %b %b", $time, in, out);
        #0 in=4'h0;
        #2 in=4'h1;
        #2 in=4'h2;
        #2 in=4'h3;
        #2 in=4'h4;
        #2 in=4'h5;
        #2 in=4'h6;
        #2 in=4'h7;
        #2 in=4'h8;
        #2 in=4'h9;
        #2 in=4'hA;
        #2 in=4'hB;
        #2 in=4'hC;
        #2 in=4'hD;
        #2 in=4'hE;
        #2 in=4'hF;
    end
endmodule