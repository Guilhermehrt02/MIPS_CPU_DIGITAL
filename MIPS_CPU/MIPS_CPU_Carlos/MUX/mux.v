module mux(
	input[31:0] a,
	input[31:0] b,
	input sel,
	output reg[31:0] mux_out
);

	initial	begin
		 mux_out = 32'd0;
	end

	always @(a,b,sel) begin
		if (sel) mux_out = b;
		else mux_out = a;
	end

endmodule
