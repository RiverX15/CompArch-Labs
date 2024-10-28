module nonblocking(in, clk,out);
    input in, clk;
    output out;
    reg q1, q2, out;
    always @ (posedge clk) begin
        q1 <= in;
        q2 <= q1;
        out <= q2;
    end
endmodule

module blocking(in, clk, out);
    input in, clk;
    output out;
    reg q1, q2, out;
    always @ (posedge clk) begin
        q1 = in;
        q2 = q1;
        out = q2;
    end
endmodule

// module testbench;
//     reg in, clk;
//     wire out;
//     blocking nb(in, clk, out);
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
//         $monitor(, $time, " clk, in, out = %b %b %b", clk, in, out);
//         in=0;
//         #4 in=1;
//         #50 in=0;
//         #50 in=1;
//         #100 $finish;
//     end
// endmodule