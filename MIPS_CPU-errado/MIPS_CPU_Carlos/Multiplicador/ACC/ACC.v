module ACC(
	output reg[32:0] Saidas,
	input [32:0] Entradas,
	input Load,
	input Sh,
	input Ad,
	input Clk,
	input Rst
);

	always @(posedge Clk)
		begin
		
		if (Rst) begin
			Saidas = 33'b0;
		end
		
		if (Ad) begin
			Saidas[32:16] = Entradas[32:16];
		end
		
		if (Sh) begin
			Saidas = {1'b0, Saidas[32:1]};
		end
		
		if (Load) begin
			Saidas[32:16] = 17'b0;
			Saidas[15:0] = Entradas[15:0];
		end
	end
endmodule
