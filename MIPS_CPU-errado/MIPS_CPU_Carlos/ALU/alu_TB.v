`timescale 1ns/10ps
module alu_TB();

	reg[31:0] A;
	reg[31:0] B;
	reg[2:0] op;
	wire[31:0] out;
	integer i;

	alu ALU(
		.A(A),
		.B(B),
		.op(op),
		.out(out)
	);

	initial begin
		A = 32'hFFFF0000;
		B = 32'h0000FFFF;
		op = 3'd0;

		for(i=0;i<5;i=i+1)
			#100 op <= i;

		#1000 $stop;
	end

endmodule
