module pc(Clk, reset, outputPc);
	input Clk;
	input reset;
	output reg [15:0] outputPc;
	
	always @(posedge Clk, posedge reset)
	begin
		if (reset)
			outputPc <= 16'b0001000000110000;//endereço inicial da memória (grupo(7) * 250h)
		else if (outputPc <= 16'b0001010000101111)//inicio + 1kword -1
			outputPc <= outputPc + 1;
			
			else
				outputPc <= 16'b0001000000110000;
	end
	
endmodule 