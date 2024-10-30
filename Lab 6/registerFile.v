// 4 REGISTERS ONLY

`include "register32bit.v"
`include "mux4to1_32bit.v"
`include "decoder2to4.v"

module registerFile(output [31:0] ReadData1, output [31:0] ReadData2, input [1:0] ReadReg1,
                    input [1:0] ReadReg2, input [1:0] WriteReg, input [31:0] WriteData, input RegWrite,
                    input clk, input reset);
    wire [31:0] reg0, reg1, reg2, reg3;
    wire [3:0] regD;
    decoder2to4 dcd1(regD, WriteReg);
    wire [3:0] regN;
    assign regN=(reset)?(regD):(4'b1111);
    register32bit r0(reg0, WriteData, clk&RegWrite&regN[0], reset);
    register32bit r1(reg1, WriteData, clk&RegWrite&regN[1], reset);
    register32bit r2(reg2, WriteData, clk&RegWrite&regN[2], reset);
    register32bit r3(reg3, WriteData, clk&RegWrite&regN[3], reset);
    mux4to1_32bit mux1(ReadData1, ReadReg1, reg0, reg1, reg2, reg3);
    mux4to1_32bit mux2(ReadData2, ReadReg2, reg0, reg1, reg2, reg3);
endmodule