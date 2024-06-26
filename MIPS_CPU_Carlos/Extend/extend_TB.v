`timescale 1ns/10ps
module extend_TB();

	reg clk;
	reg rst;
	reg[15:0] data_in;
	wire[31:0] data_out;

	extend Extend(
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.data_out(data_out)
	);

	initial begin
		clk <= 0;
		rst <= 0;
		data_in <= 16'b1111111111111111;
		#200 rst <= 1;
		#500 $stop;
	end

	always #50 clk = ~clk;

	always@(posedge clk)
		$display("%b %b %b", data_in, rst, data_out);

endmodule
