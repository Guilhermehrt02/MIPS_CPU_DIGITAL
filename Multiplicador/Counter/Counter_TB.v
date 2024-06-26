`timescale 1ns/10ps
module Counter_TB();
	reg Clk;
	reg Load;
	
	wire K;
	
	Counter Teste(
		.Clk(Clk),
		.Load(Load),
		.K(K)		
	);
	
	initial begin
		Load = 0;		
		#10 Load = 0;
		
		#10 Load = 1;
		#5 Load = 0;
	end
		
	initial 
	begin
		Clk = 0;
		forever #5 Clk = ~Clk;
	end
	
	initial 
	begin
		#800 $stop;
	end
		
endmodule
