module decoder2to4(output [3:0] out, input [1:0] sel);
    assign out[3]=sel[1]&sel[0];
    assign out[2]=sel[1]&~sel[0];
    assign out[1]=~sel[1]&sel[0];
    assign out[0]=~sel[1]&~sel[0];
endmodule