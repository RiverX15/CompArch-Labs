`include "dataMemory.v"

module tb_dm;
    reg [9:0] Address;
    reg [31:0] WriteData;
    reg MemRead, MemWrite;
    wire [31:0] ReadData;
    DataMemory dm(ReadData, Address, WriteData, MemRead, MemWrite);
    initial begin
        $monitor("%0d\tAddress WriteData MemRead MemWrite ReadData = %d %h %b %b %h", $time,
                Address, WriteData, MemRead, MemWrite, ReadData);
        #0 Address=10'b0000000000; MemRead=1'b1; MemWrite=1'b0;
        #2 Address=10'b0000000010;
        #2 Address=10'b0000010000; MemWrite=1'b1; WriteData=32'hAFAFAFAF; MemRead=1'b0;
        #2 Address=10'b0001010000; MemWrite=1'b1; WriteData=32'hAFAFAFAF;
        #2 Address=10'b0000010000; MemWrite=1'b0; MemRead=1'b1;
        #2 Address=10'b0001010000; MemRead=1'b1;
        #2 Address=10'b0001010001; MemRead=1'b1;
        #2 Address=10'b0001010001; MemRead=1'b1; WriteData=32'hDEDEBCBC; MemWrite=1'b1;
        #2 Address=10'b0001010011; MemRead=1'b0; WriteData=32'hAAAAAAAA; MemWrite=1'b1;
        #100 $finish;
    end
endmodule