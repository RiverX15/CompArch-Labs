`include "mainCtrlUnit.v"

module tb_mainCtrl;
    reg [5:0] Op;
    wire RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1;
    mainCtrlUnit mcu(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1, Op);
    initial begin
        $monitor($time, " Op RegDst ALUSrc MemToReg RegWrite MemRead MemWrite Branch ALUOp0 ALUOp1 = %b %b %b %b %b %b %b %b %b %b ", Op, RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1);
        #0 Op=6'b000000;
        #5 Op=6'b100011;
        #5 Op=6'b101011;
        #5 Op=6'b000100;
        #100 $finish;
    end
endmodule

// module tb_mainCtrl;

//     // Outputs
//     wire RegDst;
//     wire ALUSrc;
//     wire MemToReg;
//     wire RegWrite;
//     wire MemRead;
//     wire MemWrite;
//     wire Branch;
//     wire ALUOp0;
//     wire ALUOp1;

//     // Inputs
//     reg [5:0] Op;

//     // Instantiate the mainCtrlUnit module
//     mainCtrlUnit uut (
//         .RegDst(RegDst),
//         .ALUSrc(ALUSrc),
//         .MemToReg(MemToReg),
//         .RegWrite(RegWrite),
//         .MemRead(MemRead),
//         .MemWrite(MemWrite),
//         .Branch(Branch),
//         .ALUOp0(ALUOp0),
//         .ALUOp1(ALUOp1),
//         .Op(Op)
//     );

//     // Test cases
//     initial begin
//         // Monitor the outputs
//         $monitor("Time=%0t | Op=%b | RegDst=%b | ALUSrc=%b | MemToReg=%b | RegWrite=%b | MemRead=%b | MemWrite=%b | Branch=%b | ALUOp0=%b | ALUOp1=%b",
//                  $time, Op, RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1);

//         // Test for R-format instruction (Op = 000000)
//         Op = 6'b000000;
//         #10;

//         // Test for lw instruction (Op = 100011)
//         Op = 6'b100011;
//         #10;

//         // Test for sw instruction (Op = 101011)
//         Op = 6'b101011;
//         #10;

//         // Test for beq instruction (Op = 000100)
//         Op = 6'b000100;
//         #10;

//         // Test for unknown Op code
//         Op = 6'b111111;
//         #10;

//         // Finish the simulation
//         $finish;
//     end

// endmodule
