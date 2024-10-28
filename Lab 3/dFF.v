module dff_sync_clear(d, clearb, clock, q);
    input d, clearb, clock;
    output q;
    reg q;
    always @ (posedge clock)
    begin
        if (!clearb) q <= 1'b0;
        else q <= d;
    end
endmodule

module dff_async_clear(d, clearb, clock, q);
    input d, clearb, clock;
    output q;
    reg q;
    always @ (negedge clearb or posedge clock)
    begin
        if (!clearb) q <= 1'b0;
        else q <= d;
    end
endmodule

// module testbench;
//     reg d, clk, rst;
//     wire q;
//     dff_async_clear dff(d, rst, clk, q);
//     initial begin
//         forever begin
//             clk=0;
//             #5 clk=1;
//             #5 clk=0;
//         end
//     end
//     initial begin
//         $dumpfile("output.vcd");
//         $dumpvars;
//         $monitor(, $time, " d, clk, rst, q = %b %b %b %b", d, clk, rst, q);
//         d=0; rst=1;
//         #4 d=1; rst=0;
//         #50 d=1; rst=1;
//         #20 d=0; rst=0;
//         #100 $finish;
//     end
// endmodule