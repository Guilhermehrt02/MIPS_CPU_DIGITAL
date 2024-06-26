`timescale 1ns/10ps
module ADDRDecoding_TB();

	reg clk;
	reg[31:0] addr;
	wire cs;

	ADDRDecoding DUT(
	  .clk(clk),
	  .addr(addr),
	  .cs(cs)
	);

	initial begin
		clk = 1'b0;
		addr = 32'h4600;
		#100 addr = 32'h4800;
		#100 addr = 32'h4000;
		#100 addr = 32'h20cf;
		#100 $stop;
	end

	always #50 clk = ~clk;
	always #100 $display("%h \t%b", addr, cs);

endmodule
