module mainCtrlUnit(output RegDst, output ALUSrc, output MemToReg, output RegWrite, output MemRead,
                    output MemWrite, output Branch, output ALUOp0, output ALUOp1, input [5:0] Op);
    wire Rformat, lw, sw, beq;
    assign Rformat=(~Op[0])&(~Op[1])&(~Op[2])&(~Op[3])&(~Op[4])&(~Op[5]);
    assign lw=Op[0] & Op[1] & ~Op[2] & ~Op[3] & ~Op[4] & Op[5];
    assign sw=Op[0] & Op[1] & ~Op[2] & Op[3] & ~Op[4] & Op[5];
    assign beq=~Op[0] & ~Op[1] & Op[2] & ~Op[3] & ~Op[4] & ~Op[5];
    assign RegDst=Rformat;
    assign ALUSrc=lw|sw;
    assign MemToReg=lw;
    assign RegWrite=Rformat|lw;
    assign MemRead=lw;
    assign MemWrite=sw;
    assign Branch=beq;
    assign ALUOp0=Rformat;
    assign ALUOp1=beq;
endmodule