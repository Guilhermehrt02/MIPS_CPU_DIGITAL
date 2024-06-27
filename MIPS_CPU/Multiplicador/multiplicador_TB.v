`timescale 1ns/100ps
module Multiplicador_TB();
reg 	St, clk;
reg [15:0] M1;
reg [15:0] M2;
wire 	[31:0] resul;
reg rst;

Multiplicador DUT(
	.resul(resul),
	.M1(M1), 
	.M2(M2), 
	.St(St), 
	.clk(clk),
	.rst(rst)
);

	
	initial begin
		rst = 0;
		clk = 0;
		St = 0;
		M1 = 0;
		M2 = 0;
		rst = 1;
		
		#40 St = 1;
		M1 = 2000;
		M2 = 2000;
		#40 St = 0;
			
	end
	
	always #20 clk = ~clk;
	
	initial #1000 rst = 0;
	initial #1200 $stop;

endmodule
