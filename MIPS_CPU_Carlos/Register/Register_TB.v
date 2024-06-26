`timescale 1ns/10ps
module Register_TB();

	integer i;
	reg clk;
	reg rst;
	reg[31:0] data_in;
	wire[31:0] data_out;

	Register DUT(
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.data_out(data_out)
	);

	initial begin
		clk <= 0;
		rst <= 0;
		data_in <= 0;
	end

	always begin
		#500 rst <= 1;
		for(i = 0; i < 10; i=i+1)
			#100 data_in <= i;
		#1000 $stop;
	end

	always #50 clk = ~clk;
	always #100 $display("%d %d", data_in, data_out);

endmodule
