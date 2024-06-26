`timescale 1ns/10ps
module pc_TB ();

	reg clk;
	reg rst;
	wire [31:0] pc_out;

	pc DUT(
		.clk(clk),
		.rst(rst),
		.pc_out(pc_out)
	);

	initial begin
		clk = 0;
		rst = 0;
		#100 rst = 1;
		#2000 $stop;
	end

	always #50 clk = ~clk;

endmodule
