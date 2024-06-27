module ADDRDecoding(
	input [31:0] addr,
	// 0 = memoria interna, 1 = memoria externa
	output reg cs 
);
	reg [31:0] inferior, superior;
	
	// Memoria interna de 1kB (0x400 Bytes), começando em 13d * 350h = 0x2B10
	// Memoria interna 2B10h a 2F04h
	always @ (*)
	begin
		inferior = 32'h2B10;
		superior = 32'h2F0F;
		if(addr >= inferior) 
		begin
			if(addr <= superior)
			begin
				cs = 0; 
			end
			else cs = 1;
		end
		else cs = 1;	
	end 
	
endmodule 