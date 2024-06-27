module ADDRDecoding_Prog(
	input [31:0] ADDR_Prog,
	output reg CS_P 
);
	reg [31:0] inferior, superior;
	
	// Memoria programa de 1kB (0x400 Bytes), começando em 13d * 250h = 0x1E10
	// Memoria de programa 1E10h a 220Fh
	always @ (*)
	begin
		inferior = 32'h1E10;
		superior = 32'h220F;
		if(ADDR_Prog >= inferior) 
		begin
			if(ADDR_Prog <= superior)
			begin
				CS_P = 1; 
			end
			else CS_P = 0;
		end
		else CS_P = 0;	
	end 
	
endmodule 