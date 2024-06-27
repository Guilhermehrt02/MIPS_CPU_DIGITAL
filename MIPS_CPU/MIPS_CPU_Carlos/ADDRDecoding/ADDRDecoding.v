module ADDRDecoding(
	input clk,
	input [31:0] addr,
	output reg cs
);

	always @(posedge clk) begin

		if ((addr >= 32'h1DD0) && (addr <= 32'h21CF)) begin
			cs <= 1'b0;
		end 
		else begin
			cs <= 1'b1;
		end
	end

endmodule
