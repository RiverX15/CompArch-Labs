`include "instructionMemory.v"

module tb_im;
    reg [4:0] ReadAddress;
    wire [31:0] Instruction;
    InstructionMemory im(Instruction, ReadAddress);
    initial begin
        $monitor("%0d\tReadAddress Instruction = %d %h", $time, ReadAddress, Instruction);
        #0 ReadAddress=5'b00000;
        #5 ReadAddress=5'b00101;
        #5 ReadAddress=5'b01010;
        #5 ReadAddress=5'b01100;
        #100 $finish;
    end
endmodule