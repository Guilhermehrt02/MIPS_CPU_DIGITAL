module ADDRDecoding_Prog(input [31:0] ADDR_Prog,output reg CS_P );
	reg [31:0] inferior, superior;

	always @ (*)
	begin
		inferior = 32'h1030; //grupo*250h 
		superior = 32'h142F; //grupo*250h +3FFh
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