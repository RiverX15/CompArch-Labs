`include "dFF.v"
`include "shiftReg4bit.v"
`include "../Lab 1/fullAdder1bit.v"

module serialAdder(input shftCtrl, input serInp, input clk, input clear, output sm, output [3:0] serOut1);
    wire [3:0] serOut1, serOut2;
    shiftReg sr1(shftCtrl, sm, clk, serOut1);
    shiftReg sr2(shftCtrl, serInp, clk, serOut2);
    wire coutLatched, cout;
    assign coutLatched=0;
    fullAdder1bit_df fa(serOut1[0], serOut2[0], coutLatched, sm, cout);
    dff_async_clear dff(cout, clear, clk&shftCtrl, coutLatched);
endmodule