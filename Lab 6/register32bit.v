`include "dff.v"

module register32bit(output [31:0] q, input [31:0] d, input clk, input reset);
    genvar j;
    generate for (j=0; j<32; j=j+1) begin
        dff dff1(q[j], d[j], clk, reset);
    end
    endgenerate
endmodule