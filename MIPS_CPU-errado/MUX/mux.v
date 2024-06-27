module mux(select, A, B, outputMux);
	input select;
	input [31:0] A; //Sai A, quando select = 0;
	input [31:0] B; //Sai B, quando select = 1;
	
	output reg [31:0] outputMux;
	
	always@(*)
	begin
		if (select) outputMux <= B;
		else outputMux <= A;
	end
	
endmodule