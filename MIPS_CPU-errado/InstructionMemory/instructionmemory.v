module instructionmemory #(
    parameter data_WIDTH = 32, // words de 32 bits
    parameter ADDR_WIDTH = 10  // 2^10 = 1024 Enderecos
)
(
    input [ADDR_WIDTH-1:0] ADDR_Prog,
    input clk,
    output reg [data_WIDTH-1:0] dataOut
);

    reg [data_WIDTH-1:0] memoria [0:(1<<ADDR_WIDTH)-1];
    initial begin
        memoria[0] = 32'b001000_01111_00000_0001_0000_0011_0000;  // Load A
        memoria[1] = 32'b001000_01111_00001_0001_0000_0011_0001;  // Load B
        memoria[2] = 32'b001000_01111_00010_0001_0000_0011_0010;  // Load C
        memoria[3] = 32'b001000_01111_00011_0001_0000_0011_0011;  // Load D
        memoria[4] = 32'b001001_01111_00110_0001_0100_0010_1111;  // Store result

        memoria[5] = 32'b000111_00001_00000_00100_01010_100010;   // B - A
        memoria[6] = 32'b000111_00010_00011_00101_01010_100010;   // C - D
        memoria[7] = 32'b000111_00100_00101_00110_01010_110010;   // (B-A) * (C-D)

        
        memoria[8] = 32'b001000_01111_00000_0001_0000_0011_0000;  // Load A (repeat for bubble)
        memoria[9] = 32'b001000_01111_00001_0001_0000_0011_0001;  // Load B (repeat for bubble)
        memoria[10] = 32'b001000_01111_00010_0001_0000_0011_0010; // Load C (repeat for bubble)
        memoria[11] = 32'b001000_01111_00011_0001_0000_0011_0011; // Load D (repeat for bubble)

        memoria[12] = 32'b000111_00001_00000_00100_01010_100010;  // B - A (repeat for bubble)
        memoria[13] = 32'b000111_00010_00011_00101_01010_100010;  // C - D (repeat for bubble)
        memoria[14] = 32'b000111_00100_00101_00110_01010_110010;  // (B-A) * (C-D) (repeat for bubble)

        memoria[15] = 32'b001001_01111_00110_0001_0100_0010_1111; // Store result (repeat for bubble)
    end
    always @ (posedge clk)
        dataOut <= memoria[ADDR_Prog]; // leitura

endmodule
