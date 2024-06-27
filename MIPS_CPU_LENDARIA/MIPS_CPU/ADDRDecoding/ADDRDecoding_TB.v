`timescale 1ns/100ps
module ADDRDecoding_TB();
	
	reg [31:0] ADDR;
	wire CS;
	integer i;
	
	ADDRDecoding DUT(ADDR, CS);
	initial begin
		for(i = 0; i <= 16'hFFFF; i = i + 1)
			#20 ADDR = i;		
	
		$stop;
	end
	
endmodule 