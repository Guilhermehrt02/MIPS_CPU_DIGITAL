module registerfile(
    input Clk,
    input reset,
    input we, // 0-escrever, 1-leitura
    input [3:0] addressA, // Endereco do reg A
    input [3:0] addressB, // Endereco do reg B
    input [3:0] addressIn, // Endereco do reg in
    input [31:0] regIn,
    output reg [31:0] A,
    output reg [31:0] B
);

    reg [31:0] s0, s1, s2, s3, s4, s5, s6, s7;
    reg [31:0] t0, t1, t2, t3, t4, t5, t6, t7;

    always @(posedge Clk or posedge reset) begin
        if (reset) begin
            s0 <= 32'b0;
            s1 <= 32'b0;
            s2 <= 32'b0;
            s3 <= 32'b0;
            s4 <= 32'b0;
            s5 <= 32'b0;
            s6 <= 32'b0;
            s7 <= 32'b0;
            t0 <= 32'b0;
            t1 <= 32'b0;
            t2 <= 32'b0;
            t3 <= 32'b0;
            t4 <= 32'b0;
            t5 <= 32'b0;
            t6 <= 32'b0;
            t7 <= 32'b0;
            
            A <= 32'b0;
            B <= 32'b0;
        end else begin
            if (we) begin // 1-Leitura
                case (addressA)
                    4'b0000: A <= s0;
                    4'b0001: A <= s1;
                    4'b0010: A <= s2;
                    4'b0011: A <= s3;
                    4'b0100: A <= s4;
                    4'b0101: A <= s5;
                    4'b0110: A <= s6;
                    4'b0111: A <= s7;
                    4'b1000: A <= t0;
                    4'b1001: A <= t1;
                    4'b1010: A <= t2;
                    4'b1011: A <= t3;
                    4'b1100: A <= t4;
                    4'b1101: A <= t5;
                    4'b1110: A <= t6;
                    4'b1111: A <= t7;
                    default: A <= 32'b0;
                endcase
                
                case (addressB)
                    4'b0000: B <= s0;
                    4'b0001: B <= s1;
                    4'b0010: B <= s2;
                    4'b0011: B <= s3;
                    4'b0100: B <= s4;
                    4'b0101: B <= s5;
                    4'b0110: B <= s6;
                    4'b0111: B <= s7;
                    4'b1000: B <= t0;
                    4'b1001: B <= t1;
                    4'b1010: B <= t2;
                    4'b1011: B <= t3;
                    4'b1100: B <= t4;
                    4'b1101: B <= t5;
                    4'b1110: B <= t6;
                    4'b1111: B <= t7;
                    default: B <= 32'b0;
                endcase
            end else begin // 0-Escrever
                case (addressIn)
                    4'b0000: s0 <= regIn;
                    4'b0001: s1 <= regIn;
                    4'b0010: s2 <= regIn;
                    4'b0011: s3 <= regIn;
                    4'b0100: s4 <= regIn;
                    4'b0101: s5 <= regIn;
                    4'b0110: s6 <= regIn;
                    4'b0111: s7 <= regIn;
                    4'b1000: t0 <= regIn;
                    4'b1001: t1 <= regIn;
                    4'b1010: t2 <= regIn;
                    4'b1011: t3 <= regIn;
                    4'b1100: t4 <= regIn;
                    4'b1101: t5 <= regIn;
                    4'b1110: t6 <= regIn;
                    4'b1111: t7 <= regIn;
                endcase
            end
        end
    end
endmodule
