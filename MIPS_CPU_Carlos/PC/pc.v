module pc(
	input rst,
	input clk, 
	output reg [31:0] pc_out
);

	always @(posedge clk)
	begin
		if(rst==0)
			pc_out = 0;
		else
			pc_out = pc_out + 1'b1;
	end
endmodule
