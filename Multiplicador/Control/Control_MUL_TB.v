`timescale 1ns/10ps
module Control_MUL_TB();
	reg Clk;
	reg St;
	reg K;
	reg M;
	
	wire Idle;
	wire Done;
	wire Load;
	wire Sh;
	wire Ad;
	//wire [1:0]Aux;
	
	Control Teste(
		.Clk(Clk),
		.St(St),
		.K(K),
		.M(M),
		.Idle(Idle),
		.Done(Done),
		.Load(Load),
		.Sh(Sh),
		.Ad(Ad)
		//.Aux(Aux)
	);
	
	initial begin
		Clk = 0;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 1;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 0;
		St = 1;
		K = 0;
		M = 0;
		
		#10 Clk = 1;
		St = 1;
		K = 0;
		M = 0;
		
		#10 Clk = 0;
		St = 0;
		K = 0;
		M = 1;
		
		#10 Clk = 1;
		St = 0;
		K = 0;
		M = 1;
		
		#10 Clk = 0;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 1;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 0;
		St = 0;
		K = 1;
		M = 0;
		
		#10 Clk = 1;
		St = 0;
		K = 1;
		M = 0;
		
		#10 Clk = 0;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 1;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 0;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 1;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 0;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 1;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 0;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 1;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 0;
		St = 0;
		K = 0;
		M = 0;
		
		#10 Clk = 1;
		St = 0;
		K = 0;
		M = 0;
		

		
		#10;
		
	end
	
endmodule