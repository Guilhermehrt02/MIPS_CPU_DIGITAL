module ADDRDecoding_Prog(input [31:0] ADDR_Prog,output reg CS_P );
	reg [31:0] inferior, superior;
	// começando em 7d * 250h = 0x1030
	// Memoria de programa 1030h a 142Fh
	always @ (*)
	begin
		inferior = 32'h1030;
		superior = 32'h142F;
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