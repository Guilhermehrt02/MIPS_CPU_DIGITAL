module multiplicador(
	output [31:0] R,
	output Done,
	output Idle,
	input [15:0] A,
	input [15:0] B,
	input St,
	input Clk,
	input Rst
);


	wire K, Load, Sh, Ad, M;
	
	wire [32:0] saidaACC;
	wire [32:0] entradaACC;
	
	wire [16:0] soma;
	wire [16:0] operandoB;
	
	assign entradaACC = {soma,B};

	ACC ACC_0 (saidaACC, entradaACC, Load, Sh, Ad, Clk, Rst);
	Adder Adder_0 (soma, A, operandoB);
	Counter Counter_0 (Load, Clk, K);
	CONTROL Control_0 (Idle, Done, Load, Sh, Ad, St, Clk, M, K, Rst);
	
	assign operandoB = saidaACC[31:16];
	assign R = saidaACC[31:0];
	assign M = saidaACC[0];
	
endmodule
