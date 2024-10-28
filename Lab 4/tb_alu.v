`include "alu.v"

module tb_alu;
    reg [1:0] op;
    reg binvert, cin;
    reg [31:0] in1, in2;
    wire [31:0] ans;
    wire cout;
    alu alu1(cout, ans, op, binvert, in1, in2, cin);
    initial begin
        $monitor($time, " cout = %b \t ans = %b ", cout, ans);
        #0 in1=32'ha5a5a5a5;
        in2=32'h5a5a5a5b;
        op=2'b00;
        binvert=1'b0;
        cin=1'b0;
        #100 op=2'b01;
        #100 op=2'b10;
        #100 binvert=1'b1; cin=1'b1;
        #200 $finish;
    end
endmodule