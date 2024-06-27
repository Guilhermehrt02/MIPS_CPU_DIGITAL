`timescale 1ns/10ps
module datamemory_TB();

	integer i, j;
	reg clk;
	reg we;
	reg [9:0] address;
	reg [31:0] data_in;
	wire[31:0] data_out;

	datamemory DUT (
		
		.address(address),
		.data_in(data_in),
		.data_out(data_out),
		.we(we),
		.clk(clk)
	);

	initial begin
		clk = 0;
		we = 1;
		#100
		for (i=0;i<10;i=i+1) begin
			#100 data_in = i;
			#100 address = i;
		end
		#100 we = 0;
		for (j=0;j<10;j=j+1) begin
			#100 address = j;
		end
		#1000 $stop;
	end

	always #50 clk = ~clk;

	always@(posedge clk) begin
		$display("%d %d %d %d", address, data_in, data_out, we);
	end

endmodule