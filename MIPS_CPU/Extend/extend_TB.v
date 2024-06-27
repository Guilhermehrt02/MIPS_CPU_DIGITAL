`timescale 1ns/1ps
module extend_TB();
	reg [15:0] offsetIn;
	wire [31:0] immediate;
	
	extend DUT(
		.offsetIn(offsetIn),
		.immediate(immediate)	
	);
	
	initial
	begin
		offsetIn = 16'hAABB;
		#10 offsetIn = 16'h1515;
		#10 offsetIn = 16'h2044;
		#10 offsetIn = 16'hAFFC;
		#10 offsetIn = 16'h0002;
		#10 offsetIn = 16'h2323;
		#10 offsetIn = 16'h9875;
		#10 offsetIn = 16'hABCD;
		#10 offsetIn = 16'hEF01;
		
	end
	
endmodule 