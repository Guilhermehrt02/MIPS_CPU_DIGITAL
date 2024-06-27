`timescale 1ns/10ps
module mux_TB();
	reg select;
	reg [31:0] A;
	reg [31:0] B;
	
	wire [31:0] outputMux;
	
	mux Teste(
		.select(select),
		.A(A),
		.B(B),
		.outputMux(outputMux)
	);
	
	initial
	begin
		select = 0;
		A = 10;
		B = 25;
		
		#10 select = 1;
		A = 11;
		B = 9;
		
		#10 select = 0;
		A = 150;
		B = 1;
		
		#10 select = 1;
		A = 3;
		B = 15;
		
		#10;
	end
	
endmodule