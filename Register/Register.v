module Register
	#(parameter dataWidth = 32)
	(Clk, reset, regIn, regOut);
	
	input Clk;
	input reset;
	input [(dataWidth-1):0] regIn;
	output reg [(dataWidth-1):0] regOut;
	
	always @(posedge Clk, posedge reset)
	begin
		if (reset)
			regOut <= 0; //16'b0001 0000 0011 0000;
		else
			regOut <= regIn;
	end
	
endmodule
