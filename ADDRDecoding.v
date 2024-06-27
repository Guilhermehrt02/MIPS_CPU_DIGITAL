module ADDRDecoding(
	input [31:0] addr,
	// 0 = memoria interna, 1 = memoria externa
	output reg cs 
);
	reg [31:0] inferior, superior;
	
	// começando em 7 * 350h = 0x1730
	// Memoria interna 1730h a 1b2fh
	always @ (*)
	begin
		inferior = 32'h1730; superior = 32'h1b2f;
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