module REG_8BIT(output [7:0] reg_out, input [7:0] num_in, input clock, input reset);
    reg [7:0] reg_out;
    always @(posedge clock) begin
        if (reset) reg_out=8'h00;
        else reg_out=num_in;
    end
endmodule

module EXPANSION_BOX(input [3:0] in, output [7:0] out);
    assign out[0]=in[0];
    assign out[1]=in[2];
    assign out[2]=in[3];
    assign out[3]=in[1];
    assign out[4]=in[2];
    assign out[5]=in[1];
    assign out[6]=in[0];
    assign out[7]=in[3];
endmodule

module XOR_8BIT(output [7:0] xout_8, input [7:0] xin1_8, input [7:0] xin2_8);
    assign xout_8=xin1_8^xin2_8;
endmodule

module XOR_4BIT(output [3:0] xout_4, input [3:0] xin1_4, input [3:0] xin2_4);
    assign xout_4=xin1_4^xin2_4;
endmodule

module CSA_4BIT(input cin, input [3:0] inA, input [3:0] inB, output cout, output [3:0] out);
    wire couts[0:1];
    wire [3:0] outs[0:1];
    assign {couts[0], outs[0]}=inA+inB+1;
    assign {couts[1], outs[1]}=inA+inB;
    assign out=(cin)?(outs[1]):(outs[0]);
    assign cout=(cin)?(couts[1]):(couts[0]);
endmodule

module CONCAT(output [7:0] concat_out, input [3:0] concat_in1, input [3:0] concat_in2);
    assign concat_out={concat_in1, concat_in2};
endmodule

module ENCRYPT(input [7:0] number, input [7:0] key, input clock, input reset, output [7:0] enc_number);
    wire [7:0] num_reg, key_reg;
    REG_8BIT numR(num_reg, number, clock, reset);
    REG_8BIT keyR(key_reg, key, clock, reset);
    wire [7:0] expOut;
    EXPANSION_BOX exp(num_reg[3:0], expOut);
    wire [7:0] xorOut1;
    XOR_8BIT xor1(xorOut1, expOut, key_reg);
    wire [3:0] csaOut;
    wire csaCout;
    CSA_4BIT csa(key_reg[0], xorOut1[7:4], xorOut1[3:0], csaCout, csaOut);
    wire [3:0] xorOut2;
    XOR_4BIT xor2(xorOut2, num_reg[7:4], csaOut);
    wire [7:0] enc_number;
    CONCAT cnct(enc_number, xorOut2, num_reg[3:0]);
endmodule

module testbench;
    reg [7:0] number, key;
    reg clock, reset;
    wire [7:0] enc_number;
    ENCRYPT enct(number, key, clock, reset, enc_number);
    initial clock=0;
    always #1 clock=~clock;
    initial begin
        // $monitor("%0d\tnumber = %b\tkey = %b\tclock = %b\treset = %b\tenc_num = %b",
        //         $time, number, key, clock, reset, enc_number);
        $monitor("%0d\t number = %h\t key = %h\t enc_number = %h", $time, number, key, enc_number);
        #1 number=8'b0100_0110; key=8'b1001_0011; reset=0;
        #2 number=8'b1100_1001; key=8'b1010_1100;
        #2 number=8'b1010_0101; key=8'b0101_1010;
        #2 number=8'b1111_0000; key=8'b1011_0001;
        #100 $finish;
    end
endmodule