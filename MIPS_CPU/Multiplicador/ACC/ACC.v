module ACC(Clk, Sh, Ad, Load, Entradas, Saidas);
	input Clk;
	input Sh;
	input Ad;
	input Load;
	input [32:0] Entradas;
	
	output reg [32:0] Saidas;
	
	always @(posedge Clk)
	begin
		if (Load)
		begin
			Saidas[32:16] = 0;
			Saidas[15:0] = Entradas[15:0];
		end
		
		if (Sh)
				Saidas = Saidas >> 1;		
		
		if (Ad)
			Saidas[32:16] = Entradas[32:16];
		
	end

endmodule