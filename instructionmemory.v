module instructionmemory 
#(
	parameter DATA_WIDTH = 32,
	parameter ADDR_WIDTH = 10
)
(
	input [ADDR_WIDTH-1:0] address,
	input clk,
	output reg [DATA_WIDTH-1:0] dataOut
);

	reg [DATA_WIDTH-1:0] memoria [0:(1<<ADDR_WIDTH)-1];

	initial begin

		// COM PIPELINE HAZZARD	
		memoria[0] <= 32'b001000_01111_00000_0001_0000_0011_0000; // Load A 
		memoria[1] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B 
		memoria[2] <= 32'b001000_01111_00010_0001_0000_0011_0010; // Load C 
		memoria[3] <= 32'b001000_01111_00011_0001_0000_0011_0011; // Load D 
		memoria[4] <= 32'b000111_00001_00000_00100_01010_100010;  // SUB B-A 
		memoria[5] <= 32'b000111_00010_00011_00101_01010_100010;  // SUB C-D  
		memoria[6] <= 32'b000111_00100_00101_00110_01010_110010;  // MUL (B-A)*(C-D) 
		memoria[7] <= 32'b001001_01111_00110_0001_0100_0010_1111; // Store 
			
		// SEM PIPELINE HAZZARD
		memoria[8] <= 32'b001000_01111_00000_0001_0000_0011_0000;  // Load A 
		memoria[9] <= 32'b001000_01111_00001_0001_0000_0011_0001;  // Load B 
		memoria[10] <= 32'b001000_01111_00010_0001_0000_0011_0010; // Load C
		memoria[11] <= 32'b001000_01111_00011_0001_0000_0011_0011; // Load D
		
		memoria[12] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		memoria[13] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		
		memoria[14] <= 32'b000111_00001_00000_00100_01010_100010;  // SUB B-A
		memoria[15] <= 32'b000111_00010_00011_00101_01010_100010;  // SUB C-D
		
		memoria[16] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		memoria[17] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		memoria[18] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		
		memoria[19] <= 32'b000111_00100_00101_00110_01010_110010;  // MUL (B-A)*(C-D)
		
		memoria[20] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		memoria[21] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		memoria[22] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		
		memoria[23] <= 32'b001001_01111_00110_0001_0100_0010_1111; //Store 	
	
		memoria[24] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		memoria[25] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		memoria[26] <= 32'b001000_01111_00001_0001_0000_0011_0001; // Load B (Bolha)
		
	end

	always @(posedge clk) begin
			dataOut <= memoria[address];
	end

endmodule
