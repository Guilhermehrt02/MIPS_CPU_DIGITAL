`timescale 1ns/100ps
module Multiplicador_TB();
reg 	St, Clk;
reg [15:0] Multiplicando;
reg [15:0] Multiplicador;
wire 	[31:0] Produto;
wire Idle, Done;

Multiplicador DUT(
	.Produto(Produto), 
	.Idle(Idle), 
	.Done(Done), 
	.Multiplicando(Multiplicando), 
	.Multiplicador(Multiplicador), 
	.St(St), 
	.Clk(Clk)
);

	
	initial begin
		Clk = 0;
		St = 0;
		Multiplicando = 0;
		Multiplicador = 0;
		
		#40 St = 1;
		Multiplicando = 2000;
		Multiplicador = 2000;
		#40 St = 0;
			
	end
	
	always #20 Clk = ~Clk;
	
	initial #2000 $stop;

endmodule
