module extend(
	input clk,
	input rst,
	input[15:0] data_in,
	output reg[31:0] data_out
);

	always @(posedge clk) begin
		if(rst==0)
			data_out <= 0;
		else
			data_out <= {16'd0, data_in};
	end

endmodule
