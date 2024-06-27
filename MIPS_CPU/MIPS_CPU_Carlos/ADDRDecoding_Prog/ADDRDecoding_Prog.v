module ADDRDecoding_Prog(
	input clk,
	input [31:0] ADDR_Prog,
	output reg CS_P
);
	parameter r0 = 22'h14d0;
	always @(posedge clk) begin

		if ((ADDR_Prog >= 32'h14d0) && (ADDR_Prog <= 32'h18cf)) begin
			CS_P <= 1'b0;
		end 
		else begin
			CS_P <= 1'b1;
		end
	end

endmodule
