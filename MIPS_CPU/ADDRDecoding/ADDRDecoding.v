module ADDRDecoding(
	input [31:0] addr,
	// 0 = memoria interna, 1 = memoria externa
	output reg cs 
);
	reg [31:0] inferior, superior;
	
	always @ (*)
	begin
		
		inferior = 32'h1730; //grupo*350h
		superior = 32'h1b2f; //grupo*350h + 3FFh
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