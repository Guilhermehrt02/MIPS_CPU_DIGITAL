`timescale 1ns/10ps
module ADDRDecoding_Prog_TB();

	reg clk;
	reg[31:0] ADDR_Prog;
	wire CS_P;

	ADDRDecoding_Prog DUT(
	  .clk(clk),
	  .ADDR_Prog(ADDR_Prog),
	  .CS_P(CS_P)
	);

	initial begin
		clk = 1'b0;
		ADDR_Prog = 32'h4600;
		#100 ADDR_Prog = 32'h4800;
		#100 ADDR_Prog = 32'h4000;
		#100 ADDR_Prog = 32'h14f0;
		#100 $stop;
	end

	always #50 clk = ~clk;
	always #100 $display("%h \t%b", ADDR_Prog, CS_P);

endmodule
