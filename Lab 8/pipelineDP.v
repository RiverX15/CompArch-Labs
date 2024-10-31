`include "encoder.v"
`include "alu.v"
`include "evenParityGenerator.v"

module pipelineDP(output [4:0] out, input [2:0] ReadAddress, input clk);
    reg [15:0] mem[0:7];
    initial $readmemb("instructions.txt", mem);
    reg [10:0] pipelineReg[0:1];
    wire [2:0] encOut;
    wire [3:0] aluOut;
    integer j=0;
    encoder enc(encOut, mem[ReadAddress+j][15:8]);
    alu a1(aluOut, pipelineReg[0][6:3], pipelineReg[0][10:7], pipelineReg[0][2:0]);
    evenParityGenerator epg(out, pipelineReg[1][3:0]);
    always @(posedge clk) begin
        pipelineReg[1][3:0]=aluOut;
        pipelineReg[0][6:3]=mem[ReadAddress+j][7:4];
        pipelineReg[0][10:7]=mem[ReadAddress+j][3:0];
        pipelineReg[0][2:0]=encOut;
        j=j+1;
    end
endmodule