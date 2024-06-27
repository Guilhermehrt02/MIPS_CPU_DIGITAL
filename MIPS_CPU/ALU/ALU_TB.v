`timescale 1ns/10ps
module ALU_TB();
	reg [1:0] select;
	reg [31:0] A;
	reg [31:0] B;
	
	wire [31:0] result;
	
	ALU DUT(
		.select(select),
		.A(A),
		.B(B),
		.result(result)
	);
	
	initial
	begin
		select = 0;
		A = 10;
		B = 25;
		
		#10 select = 1;
		A = 11;
		B = 9;
		
		#10 select = 2;
		A = 32'hFFFFFF55;
		B = 32'hAAAAAAAA;
		
		#10 select = 3;
		A = 3;
		B = 1;
		
		#30;
	end
	
	
	
	
endmodule