module datamemory (
 	clk, 
	ADDR,          // endereco de memoria
 	din,      // entrada da memoria
 	WR_RD,
	cs,
 	dout      // saida da memoria 
);


parameter SIZE = 32; 

input clk, WR_RD, cs;
input [SIZE - 1: 0] ADDR;
input [SIZE - 1: 0] din;
integer i;

output reg [SIZE - 1: 0] dout;

reg [SIZE - 1 :0] memory [0:1023];  // 1kword de 32 bits cada 

// parametros dados no trabalho 

initial begin
    memory[0] = 32'b00000000000000000000011111010001; // A = 2001
    memory[1] = 32'b00000000000000000000111110100001; // B = 4001
    memory[2] = 32'b00000000000000000001001110001001; // C = 5001
    memory[3] = 32'b00000000000000000000101110111001; // D = 3001
    
    for (i = 4; i < 1024; i = i + 1) begin
        memory[i] = 32'b0; // Preenche o restante da memória com zeros
    end
end


always @(posedge clk) begin
 
	if (cs == 1 && WR_RD == 0) 
		memory[ADDR] <= din ;
 	else
	if(WR_RD == 1) 
		dout <= memory[ADDR];

	
end

endmodule
