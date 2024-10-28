module dff(output q, input d, input clk, input reset);
    reg q;
    always @(posedge clk) begin
        if (!reset) q<=1'b0;
        else q<=d;
    end
endmodule