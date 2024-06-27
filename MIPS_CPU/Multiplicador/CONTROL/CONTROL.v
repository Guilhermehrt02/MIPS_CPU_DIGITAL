module CONTROL(
	output reg Load, Sh, Ad,
	input clk, K, M, St, rst
);
parameter S0 = 0, S1 = 1, Done = 2;
reg	[1:0] state;
always @ (posedge clk or posedge rst) begin
	if (rst) state = Done;
	else case (state)
		S0: begin
			if (K) state <= Done;
			else state <= S1;
		end
		S1: state <= S0;
		Done: begin
			if(St) state <= S1;
			else state <= Done;
		end
	endcase
end
always @ (state, clk, K, M, rst, St)
begin
		Load = 0; Sh = 0; Ad = 0;
		case (state)
			S0: if (!K && M) Ad = 1;
			S1: Sh = 1;
			Done: Load = 1;
		endcase
end
endmodule
