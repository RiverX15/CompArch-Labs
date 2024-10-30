module InstructionMemory(output [31:0] Instruction, input [4:0] ReadAddress);
    reg [31:0] mem[0:31];   // 32 registers (memory locations) each storing a 32 bit instruction.
                            // mem[0:31] denotes size of array (number of memory locations/instructions).
                            // [31:0] mem denotes size of each instruction.
    initial $readmemh("instructions.txt", mem); // Put 32 instructions in hexadecimal format in the
                                                // file "instructions.txt"
    assign Instruction=mem[ReadAddress];
endmodule