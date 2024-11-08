// INCOMPLETE

module BHT(output [1:0] D, input [9:0] A, input [1:0] I, input WR);
    reg [1:0] data[0:1023];
    integer i;
    initial begin
        for (i=0; i<1024; i=i+1) begin
            data[i]<=2'b00;
        end
    end
    always @(negedge WR) begin
        if (!WR) data[A]=I;
    end
    assign D=data[A];
endmodule

module MUX1(output [1:0] out, input [1:0] in1, input [1:0] in2, input sel);
    assign out=sel?in2:in1;
endmodule

module PREDICTOR(output [1:0] N, input X, input reset);
    reg [1:0] N;
    always @(negedge reset) begin
        if (!reset) N<=2'b00;
        else begin
            case(N)
                2'b00: begin
                    if (X) N<=2'b01;
                    else N<=2'b00;
                end
                2'b01: begin
                    if (X) N<=2'b11;
                    else N<=2'b00;
                end
                2'b10: begin
                    if (X) N<=2'b11;
                    else N<=2'b00;
                end
                2'b11: begin
                    if (X) N<=2'b11;
                    else N<=2'b10;
                end
            endcase
        end
    end
endmodule