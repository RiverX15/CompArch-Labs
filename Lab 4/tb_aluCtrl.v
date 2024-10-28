`include "aluCtrlUnit.v"

module tb_aluCtrl;
    reg [1:0] ALUOp;
    reg [5:0] FnField;
    wire [2:0] Op;
    aluCtrlUnit alucu(Op, ALUOp, FnField);
    initial begin
        $monitor($time, " ALUOp FnField Op = %b %b %b ", ALUOp, FnField, Op);
        #0 ALUOp=2'b00; FnField=6'b000000;
        #2 ALUOp=2'b01; FnField=6'b000000;
        #2 ALUOp=2'b10; FnField=6'b000000;
        #2 ALUOp=2'b10; FnField=6'b000010;
        #2 ALUOp=2'b10; FnField=6'b000100;
        #2 ALUOp=2'b10; FnField=6'b000101;
        #2 ALUOp=2'b10; FnField=6'b001010;
        #100 $finish;
    end
endmodule