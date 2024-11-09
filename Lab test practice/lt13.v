// INCORRECT

module REG1(input clk, input EN, input [3:0] numin, output [3:0] numout);
    reg [3:0] numout;
    always @(posedge clk) begin
        if (EN) numout<=numin;
    end
endmodule

module ROTATOR(input clk, input EN, input [3:0] numo, output [3:0] numrotated);
    reg [3:0] numrotated;
    // always @(posedge clk) begin
    //     if (EN) begin
    //         numrotated<={numo[2:0], numo[3]};
    //     end
    // end
    reg state;
    initial state=1'b0;
    always @(posedge clk) begin
        if (EN) begin
            case(state)
                1'b0: begin
                    numrotated<={numo[2:0], numo[3]};
                    state<=1'b1;
                end
                1'b1: begin
                    numrotated<={numo[1:0], numo[3:2]};
                    state<=1'b0;
                end
            endcase
        end
    end
endmodule

module MULTIPLIER(input [3:0] op1, input [3:0] op2, output [7:0] product);
    reg [7:0] product;
    always @(*) product<=op1*op2;
endmodule

module DECODER(input [3:0] sel, output [15:0] out1);
    reg [15:0] out1;
    always @(*) begin
        out1<=16'b0;
        out1[sel]<=1'b1;
    end
endmodule

module MEMORY(input WE, input [7:0] datatowrite, input [3:0] regsel, output [7:0] readdata);
    reg [7:0] mem[0:15];
    reg [7:0] readdata;
    initial begin
        mem[0]=8'b0;
        mem[1]=8'b0;
        mem[2]=8'b0;
        mem[3]=8'b0;
        mem[4]=8'b0;
        mem[5]=8'b0;
        mem[6]=8'b0;
        mem[7]=8'b0;
        mem[8]=8'b0;
        mem[9]=8'b0;
        mem[10]=8'b0;
        mem[11]=8'b0;
        mem[12]=8'b0;
        mem[13]=8'b0;
        mem[14]=8'b0;
        mem[15]=8'b0;
    end
    always @(*) begin
        if (WE) mem[regsel]<=datatowrite;
        readdata<=mem[regsel];
    end
endmodule

module DATAPATH(input [3:0] num, input [3:0] key, input clk, output [7:0] storedvalue);
    wire [3:0] numout, numrotated1, numrotated;
    REG1 r1(clk, 1'b1, num, numout);
    // ROTATOR rot1(clk, 1'b1, numout, numrotated1);
    // ROTATOR rot2(clk, 1'b1, numrotated1, numrotated);
    ROTATOR rot(clk, 1'b1, numout, numrotated);
    wire [7:0] product;
    MULTIPLIER mult(numrotated, key, product);
    MEMORY mem(1'b1, product, num, storedvalue);
endmodule

module TESTBENCH;
    reg clk;
    reg [3:0] num, key;
    wire [7:0] storedvalue;
    DATAPATH dp(num, key, clk, storedvalue);
    initial clk=0;
    always #1 clk=~clk;
    initial begin
        $dumpfile("output.vcd");
        $dumpvars;
        $monitor("%0d\t num = %b\t key = %b\t storedvalue = %b", $time, num, key, storedvalue);
        #2 num=4'b1000; key=4'b1000;
        #10 num=4'b1001; key=4'b1000;
        #10 num=4'b1100; key=4'b1010;
        #10 num=4'b1011; key=4'b1110;
        #100 $finish;
    end
endmodule