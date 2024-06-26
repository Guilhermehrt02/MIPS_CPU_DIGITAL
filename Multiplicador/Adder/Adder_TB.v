`timescale 1ns/10ps
module Adder_TB();
	reg [15:0] OperandoA;
	reg [15:0] OperandoB;
	
	wire [16:0] Soma;
	
	Adder Teste(
		.OperandoA(OperandoA),
		.OperandoB(OperandoB),
		.Soma(Soma)
	);
	
	initial begin
		OperandoA = 1;
		OperandoB = 1;
		
		#10 OperandoA = 0;
		OperandoB = 3;
		
		#10 OperandoA = 16'hFFFF;
		OperandoB = 16'hFFFF;
		
		#10 OperandoA = 8;
		OperandoB = 8;
		
		#10;
		
	end
	
endmodule