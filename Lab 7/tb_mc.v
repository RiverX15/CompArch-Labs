`include "mainController.v"

module tb_mc;
    reg [5:0] Op;
    reg [3:0] S;
    reg clk;
    wire PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemToReg, ALUSrcA, RegWrite, RegDst;
    wire [1:0] PCSource, ALUOp, ALUSrcB;
    wire [3:0] NS;
    mainController mc(PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemToReg, PCSource,
                        ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, NS, Op, S);
    initial clk=0;
    always #2 clk=~clk;
    always @(posedge clk) S=NS;
    initial begin
        $monitor("%0d\nPCWrite=%b\nPCWriteCond=%b\nIorD=%b\nMemRead=%b\nMemWrite=%b\nIRWrite=%b\nMemToReg=%b\nALUSrcA=%b\nRegWrite=%b\nRegDst=%b\nPCSource=%b\nALUOp=%b\nALUSrcB=%b\nNS=%b\nOp=%b\nS=%d\n",
                $time, PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemToReg, ALUSrcA, RegWrite, RegDst, PCSource, ALUOp, ALUSrcB, NS, Op, S);
        #0 Op=6'b100011; S=4'b0000;     // LW
        #20 Op=6'b101011; S=4'b0000;    // SW
        #20 Op=6'b000000; S=4'b0000;    // R-type
        #20 Op=6'b000100; S=4'b0000;    // BEQ
        #20 Op=6'b000010; S=4'b0000;    // J
        #20 $finish;
    end
endmodule