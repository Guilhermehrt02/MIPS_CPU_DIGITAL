module multiplicador(Clk, St, Done, Idle, Multiplicando, Multiplicador, Produto);
	input Clk;
	input St;
	input [15:0] Multiplicando;
	input [15:0] Multiplicador;
	
	output Idle;
	output Done;
	output [31:0] Produto;
	
	//Wire ACC
	wire [32:0] Entradas;
	wire [32:0] Saidas;
	
	//Wire Adder
	wire [16:0] Soma;
	wire [15:0] OperandoA;
	wire [15:0] OperandoB;
	
	//Wire Control
	wire K;
	wire M;
	wire Load;
	wire Sh;
	wire Ad;		
	
	//Auxiliares
	assign OperandoA = Multiplicando;
	assign OperandoB = Saidas[31:16]; 
	assign Produto = Saidas[31:0];
	assign M = Saidas[0];
	assign Entradas[15:0] = Multiplicador;
	assign Entradas[32:16] = Soma;	
	
	ACC acumulador01(Clk, Sh, Ad, Load, Entradas, Saidas);
	Adder somador01(OperandoA, OperandoB, Soma);
	Control_MUL controle01(Clk, St, K, M, Idle, Done, Load, Sh, Ad);
	Counter contador01(Clk, Load, K);
	
endmodule