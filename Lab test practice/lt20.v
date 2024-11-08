module RSFF(output q, input s, input r, input clock, input reset);
    reg q;
    always @(posedge clock) begin
        if (reset) q<=0;
        else begin
            case ({s,r})
            2'b01: q<=0;
            2'b10: q<=1;
            2'b11: q<=1;
            endcase
        end
    end
endmodule

module DFF(output q, input d, input clock, input reset);
    // reg q;
    RSFF rs(q, d, ~d, clock, reset);
endmodule

// module tb_dff;
//     reg d, clock, reset;
//     wire q;
//     DFF dff(q, d, clock, reset);
//     initial clock=0;
//     always #2 clock=~clock;
//     initial begin
//         $monitor("%0d\td = %b\tclock = %b\treset = %b\tq = %b", $time, d, clock, reset, q);
//         #0 d=0; reset=1;
//         #5 d=1; reset=0;
//         #5 d=0;
//         #5 d=1;
//         #5 d=0;
//         #5 d=1;
//         #7 reset=1;
//         #100 $finish;
//     end
// endmodule

module RIPPLE_COUNTER(output [3:0] q, input clock, input reset);
    DFF d0(q[0], ~q[0], clock, reset);
    DFF d1(q[1], ~q[1], ~q[0], reset);
    DFF d2(q[2], ~q[2], ~q[1], reset);
    DFF d3(q[3], ~q[3], ~q[2], reset);
endmodule

module MEM1(output [7:0] out8, output out1, input [2:0] addr);
    reg [8:0] mem[0:7];
    initial begin
        mem[0]=9'b000111111;
        mem[1]=9'b001100011;
        mem[2]=9'b010100111;
        mem[3]=9'b011101011;
        mem[4]=9'b100101111;
        mem[5]=9'b101110011;
        mem[6]=9'b110110111;
        mem[7]=9'b111111011;
    end
    assign out8=mem[addr][8:1];
    assign out1=mem[addr][0];
endmodule

module MEM2(output [7:0] out8, output out1, input [2:0] addr);
    reg [8:0] mem[0:7];
    initial begin
        mem[0]=9'b000000000;
        mem[1]=9'b001000100;
        mem[2]=9'b010001000;
        mem[3]=9'b011001100;
        mem[4]=9'b100010000;
        mem[5]=9'b101010100;
        mem[6]=9'b110011000;
        mem[7]=9'b111011100;
    end
    assign out8=mem[addr][8:1];
    assign out1=mem[addr][0];
endmodule

module MUX2To1(output out, input in1, input in2, input sel);
    assign out=(sel)?(in2):(in1);
endmodule

module MUX16To8(output [7:0] out, input [7:0] in1, input [7:0] in2, input sel);
    genvar j;
    for (j=0; j<8; j=j+1) begin
        MUX2To1 mux(out[j], in1[j], in2[j], sel);
    end
endmodule

module FETCH_DATA(output [7:0] out8, output out1, input [3:0] addr);
    wire [7:0] in1_8, in2_8;
    wire in1_1, in2_1;
    MEM1 m1(in1_8, in1_1, addr[2:0]);
    MEM2 m2(in2_8, in2_1, addr[2:0]);
    MUX16To8 mux16(out8, in1_8, in2_8, addr[3]);
    MUX2To1 mux2(out1, in1_1, in2_1, addr[3]);
endmodule

module PARITY_CHECKER(output out, input [7:0] data, input parity);
    wire par;
    assign par=data[0]^data[1]^data[2]^data[3]^data[4]^data[5]^data[6]^data[7];
    assign out=(par&parity)|(~par&~parity);
endmodule

module DESIGN(output out, input clock, input reset);
    wire [3:0] addr;
    RIPPLE_COUNTER ripp1(addr, clock, reset);
    wire [7:0] data;
    wire parity;
    FETCH_DATA fetc1(data, parity, addr);
    PARITY_CHECKER pari1(out, data, parity);
endmodule

module TESTBENCH;
    reg clock, reset;
    wire out;
    initial clock=0;
    always #2 clock=~clock;
    DESIGN des1(out, clock, reset);
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        $monitor("%0d\tclock = %b\treset = %b\tout= %b", $time, clock, reset, out);
        #0 reset=1;
        #17 reset=0;
        #100 $finish;
    end
endmodule