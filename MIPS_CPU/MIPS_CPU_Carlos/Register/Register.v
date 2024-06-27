module Register(
	input clk,
	input rst,
	input[31:0] data_in,
	output reg[31:0] data_out
);
	
	always @(posedge clk) begin
		if(rst==0) begin
			data_out <= 0;
		end
		else begin
			data_out <= data_in;
		end
	end

endmodule
