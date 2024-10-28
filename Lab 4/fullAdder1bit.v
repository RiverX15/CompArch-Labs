module fullAdder1bit(output cout, output sum, input in1, input in2, input cin);
    assign {cout,sum}=in1+in2+cin;
endmodule