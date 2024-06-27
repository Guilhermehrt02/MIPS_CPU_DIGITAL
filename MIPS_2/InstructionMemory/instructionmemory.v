module instructionmemory
#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 10)
(
	input [(ADDR_WIDTH-1):0] ADDR_Prog,
	input clk, rst,
	output reg [(DATA_WIDTH-1):0] data_out
);

reg [DATA_WIDTH-1:0] memoria[2**ADDR_WIDTH-1:0];

integer i;
integer offset = 32'h1730; //grupo * 350h

initial begin
	for (i = 0; i < 2**ADDR_WIDTH - 1; i = i + 1) begin
		memoria[i] = 0;
	end
	// Pipeline Hazard
	memoria[0] <= 32'b001000_01111_00000_0001_0111_0011_0000; // Load A 
	memoria[1] <= 32'b001000_01111_00001_0001_0111_0011_0001; // Load B 
	memoria[2] <= 32'b001000_01111_00010_0001_0111_0011_0010; // Load C 
	memoria[3] <= 32'b001000_01111_00011_0001_0111_0011_0011; // Load D 
	memoria[4] <= 32'b000111_00001_00000_00100_01010_100010;  // SUB B-A 
	memoria[5] <= 32'b000111_00010_00011_00101_01010_100010;  // SUB C-D  
	memoria[6] <= 32'b000111_00100_00101_00110_01010_110010;  // MUL (B-A)*(C-D) 
	memoria[7] <= 32'b001001_01111_00110_0001_1011_0010_1111; // Store
	
	// Inserção de bolhas

	memoria[8] <= 32'b001000_01111_00000_0001_0111_0011_0001;  // Load A 
	memoria[9] <= 32'b001000_01111_00001_0001_0111_0011_0010;  // Load B 
	memoria[10] <= 32'b001000_01111_00010_0001_0111_0011_0010; // Load C
	memoria[11] <= 32'b001000_01111_00011_0001_0111_0011_0011; // Load D
	
	memoria[12]= 32'h00000000;	 //Bolha
	
	memoria[13] <= 32'b000111_00001_00000_00100_01010_100010;  // SUB B-A
	
	memoria[14]= 32'h00000000;	 //Bolha
	memoria[15]= 32'h00000000;	 //Bolha
	memoria[16]= 32'h00000000;	 //Bolha
	
	memoria[17] <= 32'b000111_00010_00011_00101_01010_100010;  // SUB C-D
	
	memoria[18]= 32'h00000000;	 //Bolha
	memoria[19]= 32'h00000000; 	 //Bolha
	memoria[20]= 32'h00000000;	 //Bolha
	
	memoria[21] <= 32'b000111_00100_00101_00110_01010_110010;  // MUL (B-A)*(C-D)
	
	memoria[22]= 32'h00000000;	 //Bolha
	memoria[23]= 32'h00000000;	 //Bolha
	memoria[24]= 32'h00000000; 	 //Bolha
	
	memoria[25] <= 32'b001001_01111_00110_0001_1011_0010_1111; //Store						 
end

always @ (posedge clk or posedge rst) begin
	data_out <= rst ? 0 : memoria[ADDR_Prog - offset];
end

endmodule
