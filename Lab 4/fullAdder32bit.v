module fullAdder32bit(output cout, output [31:0] sum, input [31:0] in1, input [31:0] in2, input cin);
    assign {cout,sum}=in1+in2+cin;
endmodule