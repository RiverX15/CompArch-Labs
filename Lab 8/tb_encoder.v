`include "encoder.v"

module tb_encoder;
    reg [7:0] fncode;
    wire [2:0] opcode;
    encoder enc(opcode, fncode);
    initial begin
        $monitor("%0d\tfncode opcode = %b %b", $time, fncode, opcode);
        #0 fncode=8'h01;
        #2 fncode=8'h02;
        #2 fncode=8'h04;
        #2 fncode=8'h08;
        #2 fncode=8'h10;
        #2 fncode=8'h20;
        #2 fncode=8'h40;
        #2 fncode=8'h80;
    end
endmodule