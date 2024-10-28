module aluCtrlUnit(output [2:0] Op, input [1:0] ALUOp, input [5:0] FnField);
    assign Op[2]=ALUOp[0]|(ALUOp[1]&FnField[1]);
    assign Op[1]=~ALUOp[1]|~FnField[2];
    assign Op[0]=ALUOp[1]&(FnField[0]|FnField[3]);
endmodule