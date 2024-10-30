module signExtender(output [31:0] out, input [15:0] in);
    genvar i;
    generate for (i=16; i<32; i=i+1) begin
        assign out[i]=in[15];
        assign out[i-16]=in[i-16];
    end
    endgenerate
endmodule