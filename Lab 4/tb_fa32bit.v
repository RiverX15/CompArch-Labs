`include "fullAdder32bit.v"

module tb_fa32bit;
    reg [31:0] in1, in2;
    reg cin;
    wire [31:0] sum;
    wire cout;
    fullAdder32bit fa(cout, sum, in1, in2, cin);
    initial begin
        $monitor($time, " in1 in2 cin sum cout = %b %b %b %b %b ", in1, in2, cin, sum, cout);
        #0 in1=32'b01010101010101010101010101010101; in2=32'b10101010101010101010101010101010; cin=1'b0;
        #2 in1=32'b01010101010101010101010101010101; in2=32'b10101010101010101010101010101010; cin=1'b1;
        #2 in1=32'b11111111111111110111111111111111; in2=32'b11111111111111111111110000000000; cin=1'b0;
        #100 $finish;
    end
endmodule        