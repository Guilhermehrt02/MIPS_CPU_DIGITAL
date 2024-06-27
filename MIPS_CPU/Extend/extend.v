module extend(offsetIn, immediate);
	input [15:0] offsetIn;
	output [31:0] immediate;
	
	assign immediate = {16'b0, offsetIn};

endmodule 