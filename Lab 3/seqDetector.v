module seqDetector(input clk, input rst, input inp);
    reg [2:0] state;
    parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state<=s0;
        end
        else begin
            case (state)
                s0: begin
                    if (inp) state<=s1;
                    else state<=s0;
                end
                s1: begin
                    if (inp) state<=s1;
                    else state<=s2;
                end
                s2: begin
                    if (inp) state<=s3;
                    else state<=s0;
                end
                s3: begin
                    if (inp) state<=s4;
                    else state<=s2;
                end
                s4: begin
                    if (inp) state<=s1;
                    else begin
                        $display("Sequence detected");
                        state<=s2;
                    end
                end
                default: begin
                    state<=s0;
                end
            endcase
        end
    end
endmodule