`timescale 1ns/10ps
module Register_TB();
	reg Clk;
	reg reset;
	reg [31:0] regIn;
	wire [31:0] regOut;
	
	Register DUT( 
		.Clk(Clk),
		.reset(reset),
		.regIn(regIn),
		.regOut(regOut)
	);
	
	initial 
	begin
		regIn = 32'hFFFFFFFF;
		#20 regIn = 32'hFFFFFF22;
		#20 regIn = 32'hFFFFFF22;
		#20 regIn = 32'hFFAAFF22;
		#20 regIn = 32'hBB44FF22;
		#20 regIn = 32'h1623FF22;
	end
	
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