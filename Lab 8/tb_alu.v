`include "alu.v"

module tb_alu;
    reg [3:0] a, b;
    reg [2:0] opcode;
    wire [3:0] x;
    alu al(x, a, b, opcode);
    initial begin
        $monitor("%0d\ta b opcode x = %b:%d %b:%d %b %b:%d", $time, a, a, b, b, opcode, x, x);
        #0 a=4'd10; b=4'd4; opcode=3'b000;
        #2 opcode=3'b001;
        #2 opcode=3'b010;
        #2 opcode=3'b011;
        #2 opcode=3'b100;
        #2 opcode=3'b101;
        #2 opcode=3'b110;
        #2 opcode=3'b111;
    end
endmodule