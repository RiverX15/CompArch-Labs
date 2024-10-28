`include "seqDetector.v"

module tb_seqDtc;
    reg clk, rst, inp;
    reg [0:15] sequence;
    integer i;
    seqDetector sd(clk, rst, inp);
    // initial clk=0;
    // always #2 clk=~clk;
    always @(posedge clk) $display($time, " clk rst inp state = %b %b %b %b", clk, rst, inp, sd.state);
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        // always @(posedge clk) $monitor($time, " clk rst inp state = %b %b %b %b", clk, rst, inp, sd.state);
        clk=0;
        rst=1;
        // sequence=16'b0110_1011_1101_1000;
        sequence=16'b1011_0000_1011_0000;
        #4 rst<=0;
        for (i=0; i<=15; i=i+1) begin
            inp=sequence[i];
            #2 clk=1;
            #2 clk=~clk;
        end
        #100 $finish;
    end
endmodule