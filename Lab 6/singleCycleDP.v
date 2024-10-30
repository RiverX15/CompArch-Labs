// INCOMPLETE

`include "instructionMemory.v"
`include "dataMemory.v"
`include "registerFile.v"
`include "alu.v"
`include "aluCtrlUnit.v"
`include "mainCtrlUnit.v"
`include "signExtender.v"
`include "leftShifter.v"
`include "fullAdder32bit.v"
`include "mux2to1_32bit.v"

module singleCycleDP(output [31:0] ALUOut, input [4:0] PC, input clk, input reset);
    wire [31:0] Instruction;
    InstructionMemory im(Instruction, PC);
    assign PC=PC+1;
    wire RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1;
    mainCtrlUnit mcu(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0,
                    ALUOp1, Instruction[31:26]);
    wire [31:0] ReadData1, ReadData2, WriteData;
    wire [1:0] ReadReg1, ReadReg2, WriteReg;
    assign ReadReg1=Instruction[22:21];
    assign ReadReg2=Instruction[17:16];
    assign WriteReg=(RegDst)?(Instruction[12:11]):(ReadReg2);
    registerFile regFile(ReadData1, ReadData2, ReadReg1, ReadReg2, WriteReg, WriteData, RegWrite,
                        clk, reset);
    wire [2:0] Op;
    aluCtrlUnit alucu(Op, {ALUOp1, ALUOp0}, Instruction[5:0]);
