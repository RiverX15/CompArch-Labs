module mainController(output PCWrite, output PCWriteCond, output IorD, output MemRead,
                        output MemWrite, output IRWrite, output MemToReg, output [1:0] PCSource,
                        output [1:0] ALUOp, output [1:0] ALUSrcB, output ALUSrcA, output RegWrite,
                        output RegDst, output [3:0] NS, input [5:0] Op, input [3:0] S);
    wire [16:0] Prod;
    assign Prod[0]=~S[0] & ~S[1] & ~S[2] & ~S[3];
    assign Prod[1]=S[0] & ~S[1] & ~S[2] & ~S[3];
    assign Prod[2]=~S[0] & S[1] & ~S[2] & ~S[3];
    assign Prod[3]=S[0] & S[1] & ~S[2] & ~S[3];
    assign Prod[4]=~S[0] & ~S[1] & S[2] & ~S[3];
    assign Prod[5]=S[0] & ~S[1] & S[2] & ~S[3];
    assign Prod[6]=~S[0] & S[1] & S[2] & ~S[3];
    assign Prod[7]=S[0] & S[1] & S[2] & ~S[3];
    assign Prod[8]=~S[0] & ~S[1] & ~S[2] & S[3];
    assign Prod[9]=S[0] & ~S[1] & ~S[2] & S[3];
    assign Prod[10]=S[0] & ~S[1] & ~S[2] & ~S[3] & ~Op[0] & Op[1] & ~Op[2] & ~Op[3] & ~Op[4] & ~Op[5];
    assign Prod[11]=S[0] & ~S[1] & ~S[2] & ~S[3] & ~Op[0] & ~Op[1] & Op[2] & ~Op[3] & ~Op[4] & ~Op[5];
    assign Prod[12]=S[0] & ~S[1] & ~S[2] & ~S[3] & ~Op[0] & ~Op[1] & ~Op[2] & ~Op[3] & ~Op[4] & ~Op[5];
    assign Prod[13]=~S[0] & S[1] & ~S[2] & ~S[3] & Op[0] & Op[1] & ~Op[2] & Op[3] & ~Op[4] & Op[5];
    assign Prod[14]=S[0] & ~S[1] & ~S[2] & ~S[3] & Op[0] & Op[1] & ~Op[2] & ~Op[3] & ~Op[4] & Op[5];
    assign Prod[15]=S[0] & ~S[1] & ~S[2] & ~S[3] & Op[0] & Op[1] & ~Op[2] & Op[3] & ~Op[4] & Op[5];
    assign Prod[16]=~S[0] & S[1] & ~S[2] & ~S[3] & Op[0] & Op[1] & ~Op[2] & ~Op[3] & ~Op[4] & Op[5];
    assign PCWrite=Prod[0]|Prod[9];
    assign PCWriteCond=Prod[8];
    assign IorD=Prod[3]|Prod[5];
    assign MemRead=Prod[0]|Prod[3];
    assign MemWrite=Prod[5];
    assign IRWrite=Prod[0];
    assign MemToReg=Prod[4];
    assign PCSource[1]=Prod[9];
    assign PCSource[0]=Prod[8];
    assign ALUOp[1]=Prod[6];
    assign ALUOp[0]=Prod[8];
    assign ALUSrcB[1]=Prod[1]|Prod[2];
    assign ALUSrcB[0]=Prod[0]|Prod[1];
    assign ALUSrcA=Prod[2]|Prod[6]|Prod[8];
    assign RegWrite=Prod[4]|Prod[7];
    assign RegDst=Prod[7];
    assign NS[3]=Prod[10]|Prod[11];
    assign NS[2]=Prod[3]|Prod[6]|Prod[12]|Prod[13];
    assign NS[1]=Prod[6]|Prod[12]|Prod[14]|Prod[15]|Prod[16];
    assign NS[0]=Prod[0]|Prod[6]|Prod[10]|Prod[13]|Prod[16];
endmodule