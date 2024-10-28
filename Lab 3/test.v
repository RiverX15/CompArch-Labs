module testbench;
    reg clk;
    initial begin
        forever begin
            clk=0;
            #5 clk=1;
            #5 clk=0;
        end
    end
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        $monitor(, $time, " clk = %d", clk);
        #100 $finish;
    end
endmodule