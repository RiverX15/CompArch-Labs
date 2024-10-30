module DataMemory(output [31:0] ReadData, input [9:0] Address, input [31:0] WriteData,
                    input MemRead, input MemWrite);
    reg [31:0] mem[0:1023];
    initial $readmemh("data.txt", mem);
    assign ReadData=(MemRead)?(mem[Address]):(ReadData);
    always @(MemWrite or Address or WriteData) if (MemWrite) mem[Address]=WriteData;
endmodule