`timescale 1ns/10ps
module multiplicador_TB();

	reg St, Clk, Rst;
	reg [15:0] A, B;
	wire Idle, Done;
	wire[31:0] R;

	multiplicador DUT(
		.Clk(Clk),
		.Rst(Rst),
		.St(St),
		.A(A),
		.B(B),
		.R(R),
		.Idle(Idle),
		.Done(Done)
	);

	initial begin
	
		A = 16'b0000_0000_0000_1101;
		B = 16'b0000_0000_0000_1011;
		Clk = 0;
		St = 0;
		Rst = 1;
		#5 Rst = 0;
		#5 St = 1;
		//#50 St = 0; 
		#1000 $stop;
	end

	always #10 Clk = ~Clk;
	
endmodule
