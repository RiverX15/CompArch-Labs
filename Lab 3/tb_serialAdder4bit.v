// INCORRECT

`include "serialAdder4bit.v"

module tb_serialAdder;
    reg shftCtrl, serInp, clk, clear;
    wire sm;
    wire [3:0] serOut1;
    reg [0:19] sequence;
    integer i;
    serialAdder sa(shftCtrl, serInp, clk, clear, sm, serOut1);
    always @(posedge clk) $display($time, " >> shftCtrl serInp clear sm serOut1 = %b %b %b %b %b ", shftCtrl, serInp, clear, sm, serOut1);
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        clk=0;
        clear=0;
        shftCtrl=1;
        sequence=20'b0100_0011_0010_0001_0000;
        #4 clear=1;
        for (i=0; i<=19; i=i+1) begin
            serInp=sequence[i];
            #2 clk=1;
            #2 clk=0;
        end
        #100 $finish;
    end
endmodule