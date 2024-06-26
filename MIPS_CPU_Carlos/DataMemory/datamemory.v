module datamemory(
	input [9:0] address,
	input [31:0] data_in,
	output reg [31:0] data_out,
	input clk,
	input we
);

	parameter n_words = 1024;
	parameter word_size = 32;

	//Memoria de 1KWord, Word = 32 bits
	reg [word_size-1:0] m [0: n_words-1];

	//Inicializa a memoria com os valores de A, B, C e D
	initial begin
		m[10'hDD0] = 32'd2001;
		m[10'hDD1] = 32'd4001;
		m[10'hDD2] = 32'd5001;
		m[10'hDD3] = 32'd3001;
	end

	always @(posedge clk) begin
		if (we) m[address] = data_in;
		else data_out = m[address];
	end

endmodule
