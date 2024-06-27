module Adder (
	output [16:0] resul,
	input [15:0] op_A, op_B
);
assign resul = op_A + op_B;
endmodule
