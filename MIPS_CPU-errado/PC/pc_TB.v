`timescale 1ns/10ps
module pc_TB();
	reg Clk;
	reg reset;
	
	wire [9:0] outputPc;
	
	pc DUT(
		.Clk(Clk),
		.reset(reset),
		.outputPc(outputPc)
	);
	
	initial
	begin
		reset = 0;
		#10 reset = 1;
		#10 reset = 0;
		#160 reset = 1;
		#10 reset = 0;
	end
	
	initial
	begin
		Clk = 0;
		forever #10 Clk = ~Clk;
	end
	
	initial 
	begin
		#200 $stop;
	end
	
endmodule