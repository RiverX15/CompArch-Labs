module jkff(output q, input j, input k, input clk);
    reg q;
    initial q=0;
    always @(negedge clk) begin
        case ({j,k})
            2'b00: q<=q;
            2'b01: q<=0;
            2'b10: q<=1;
            2'b11: q<=~q;
        endcase
        // q<=(j&~q)|(~k&q);
    end
endmodule

module BCD_Counter(output [3:0] Q_out, input clk);
    wire q0, q1, q2, q3;
    jkff f0(q0, 1'b1, 1'b1, clk);
    jkff f1(q1, ~q3, 1'b1, q0);
    jkff f2(q2, 1'b1, 1'b1, q1);
    wire Q12;
    and a1(Q12, q1, q2);
    jkff f3(q3, Q12, 1'b1, q0);
    assign Q_out={q3, q2, q1, q0};
endmodule

// module tb_bcd;
//     reg clk;
//     wire [3:0] Q_out;
//     initial clk=0;
//     always #2 clk=~clk;
//     BCD_Counter bcd(Q_out[3], Q_out[2], Q_out[1], Q_out[0], clk);
//     initial begin
//         $dumpfile("output.vcd");
//         $dumpvars;
//         $monitor("%0d\t clk = %b\t Q_out = %b", $time, clk, Q_out);
//         #100 $finish;
//     end
// endmodule

module MEM_16(output [15:0] D_16, input [3:0] A_4);
    reg [15:0] mem[0:15];
    reg [15:0] D_16;
    initial begin
        mem[0]=16'h0001;
        mem[1]=16'h0002;
        mem[2]=16'h0004;
        mem[3]=16'h0008;
        mem[4]=16'h0010;
        mem[5]=16'h0020;
        mem[6]=16'h0000;
        mem[7]=16'h0000;
        mem[8]=16'h0000;
        mem[9]=16'h0000;
        mem[10]=16'h0400;
        mem[11]=16'h0800;
        mem[12]=16'h1000;
        mem[13]=16'h0000;
        mem[14]=16'h0000;
        mem[15]=16'h0000;
    end
    always @(*) D_16=mem[A_4];
endmodule

module MUX_16(output O, input [15:0] I_16, input [3:0] S_4);
    reg O;
    always @(I_16[S_4]) O=I_16[S_4];
endmodule

module INTG(output OUT, input clk);
    wire [3:0] Q_out;
    BCD_Counter bcd(Q_out, clk);
    wire [15:0] D_16;
    MEM_16 mem(D_16, Q_out);
    MUX_16 mux(OUT, D_16, Q_out);
endmodule

module testbench;
    reg clk;
    wire OUT;
    initial clk=0;
    always #2 clk=~clk;
    INTG intg(OUT, clk);
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        $monitor("%0d\tclk Q_out D_16 OUT = %b %d %h %b", $time, clk, intg.Q_out, intg.D_16, OUT);
        #88 $finish;
    end
endmodule