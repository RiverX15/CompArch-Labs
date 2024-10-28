`include "registerFile.v"

module tb_regFile;
    reg [1:0] ReadReg1, ReadReg2, WriteReg;
    reg [31:0] WriteData;
    reg RegWrite, clk, reset;
    wire [31:0] ReadData1, ReadData2;
    registerFile rf(ReadData1, ReadData2, ReadReg1, ReadReg2, WriteReg, WriteData, RegWrite, clk, reset);
    initial clk=1'b0;
    always #5 clk=~clk;
    initial begin
        $monitor("%0d\tReadReg1\tReadReg2\tWriteReg\tWriteData\tRegWrite\tclk\treset\tReadData1\tReadData2 \n\t%b\t\t%b\t\t%b\t\t%h\t%b\t\t%b\t%b\t%h\t%h\n\n", 
        $time, ReadReg1, ReadReg2, WriteReg, WriteData, RegWrite, clk, reset, ReadData1, ReadData2);
        #2 reset=1'b0;
        #10 reset=1'b1; RegWrite=1'b1; ReadReg1=2'b00;
        WriteReg=2'b00; WriteData=32'hAFAFDEDE;
        #10 ReadReg2=2'b01;
        WriteReg=2'b01; WriteData=32'hAFAFDDDD;
        #10 ReadReg1=2'b10;
        WriteReg=2'b10; WriteData=32'hCCCCDDDD;
        #10 ReadReg2=2'b11;
        WriteReg=2'b11; WriteData=32'hBBBBBBBB;
        #10 reset=1'b0;
        #5 ReadReg1=2'b00; ReadReg2=2'b01;
        #5 ReadReg1=2'b10; ReadReg2=2'b11;
        #100 $finish;
    end
endmodule