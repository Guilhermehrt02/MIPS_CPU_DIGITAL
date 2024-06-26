module alu(
	input [31:0] A,
	input [31:0] B,
	input [2:0] op,
	output reg [31:0] out
);

	initial	begin
		 out = 32'd0;
	end

	always @(A,B,op) begin
		
		if (op == 0) begin
			out = A + B;
		end
		
		else if (op == 1) begin
			out = A - B;
		end
		
		else if (op == 2) begin
			out = A & B;
		end
		
		else if (op == 3) begin
			out = A | B;
		end
		
		else begin
			out = 32'd0;
		end
		
	end

endmodule
