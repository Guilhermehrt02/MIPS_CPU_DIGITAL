`timescale 1ns/10ps
module instructionmemory_TB();

	reg clk;
	reg[31:0] pc;
	wire[31:0] ins_out;

	instructionmemory DUT(
		.pc(pc),
		.ins_out(ins_out),
		.clk(clk)
	);

	initial begin
		clk = 0;
		pc = 0;
		#2000 $stop;
	end

	always #50 clk = ~clk;

	always @(posedge clk) begin
		pc = pc + 1;
		$display("%d \t%b", pc, ins_out);
	end

endmodule
