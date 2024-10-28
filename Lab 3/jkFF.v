module jkFF(input j, input k, input clk, input rst, output q);
    reg q;
    always @(posedge clk) begin
        if (rst) q<=1'b0;
        else q<=(j & ~q)|(~k & q);
    end
endmodule