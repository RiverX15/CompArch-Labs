`include "pipelineDP.v"

module tb_DP;
    reg [2:0] ReadAddress;
    reg clk;
    wire [4:0] out;
    pipelineDP dp(out, ReadAddress, clk);
    initial clk=0;
    always #2 clk=~clk;
    initial begin
        $monitor("%0d\tclk j encOut aluOut out = %b %0d %b %b %b", $time, clk,
                dp.j, dp.encOut, dp.aluOut, out);
        #0 ReadAddress=3'b000;
        #100 $finish;
    end
endmodule