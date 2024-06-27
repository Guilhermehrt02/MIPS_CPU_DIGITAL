module instructionmemory
#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 10)
(
	input [(ADDR_WIDTH-1):0] ADDR_Prog,
	input clk, rst,
	output reg [(DATA_WIDTH-1):0] data_out
);


// Declare the ROM variable
reg [DATA_WIDTH-1:0] mem[2**ADDR_WIDTH-1:0];

integer i;
integer offset = 32'h1e10;

initial begin
	for (i = 0; i < 2**ADDR_WIDTH - 1; i = i + 1) begin
		mem[i] = 0;
	end
	// Pipeline Hazard
	mem[0]= 32'h3be02b10;    //Carrega A em R0;
	mem[1]= 32'h3be12b11;	 //Carrega B em R1;
	mem[2]= 32'h3be22b12;	 //Carrega C em R2;
	mem[3]= 32'h3be32b13;	 //Carrega D em R3;
	mem[4]= 32'h342022a2;	 //R4 recebe B-A;
	mem[5]= 32'h34432aa2;	 //R5 recebe C-D;
	mem[6]= 32'h348532b2; 	 //R6 recebe [R4] * [R5]
	mem[7]= 32'h3fe62f0f; 	 //MemDados [2f0fh] recebe [R6]
	// Inserção de bolhas
	mem[8]= 32'h3be02b10;	 //Carrega A em R0;
	mem[9]= 32'h3be12b11;	 //Carrega B em R1;
	mem[10]= 32'h3be22b12;	 //Carrega C em R3;
	mem[11]= 32'h3be32b13;	 //Carrega D em R4;
	mem[12]= 32'h00000000;	 //Bolha
	mem[13]= 32'h342022a2;	 //R4 recebe B-A;
	mem[14]= 32'h00000000;	 //Bolha
	mem[15]= 32'h00000000;	 //Bolha
	mem[16]= 32'h00000000;	 //Bolha
	mem[17]= 32'h34432aa2;   //R5 recebe C-D;
	mem[18]= 32'h00000000;	 //Bolha
	mem[19]= 32'h00000000; 	 //Bolha
	mem[20]= 32'h00000000;	 //Bolha
	mem[21]= 32'h348532b2;	 //R6 recebe [R4] * [R5]
	mem[22]= 32'h00000000;	 //Bolha
	mem[23]= 32'h00000000;	 //Bolha
	mem[24]= 32'h00000000; 	 //Bolha
	mem[25]= 32'h3fe62f0f;	 //MemDados [2f0fh] recebe [R6]						 
end

always @ (posedge clk or posedge rst) begin
	data_out <= rst ? 0 : mem[ADDR_Prog - offset];
end

endmodule
