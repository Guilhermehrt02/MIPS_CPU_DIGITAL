module ACC (
	output reg [32:0] out,
	input [16:0] sum,
	input [15:0] M2,
	input [15:0] M1,
	input Load, Sh, Ad, clk, rst
);

always @ (posedge clk or posedge rst) begin
	if (rst) out = 0;
	else if (Load) begin
		out = { M2[0] ? M1 : 0, M2 };
	end
	else if (Sh) out = { 1'b0, out[32:1]};
	else if (Ad) out[32:16] = sum;
end
endmodule
