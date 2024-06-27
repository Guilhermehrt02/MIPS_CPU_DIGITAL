`timescale 1ns/10ps
module control_TB();
	reg [31:0] instructionIn;
	wire [19:0] controlOut;
	
	control DUT(
		   .instructionIn(instructionIn),
		   .controlOut(controlOut)
	);					 			
	
	initial
	begin
		#100 $stop;
	end
	
	initial
	begin
		    instructionIn = 32'b001000_01111_00000_0001_0000_0011_0000; //Instruction LW
		#10 instructionIn = 32'b001001_01111_00110_0001_0100_0010_1111; //Instruction SW
		#10 instructionIn = 32'b000111_00001_00000_00100_01010_100000; //Instruction ADD 
		#10 instructionIn = 32'b000111_00001_00000_00100_01010_100010; //Instruction SUB 
		#10 instructionIn = 32'b000111_00001_00000_00100_01010_110010; //Instruction MUL
		#10 instructionIn = 32'b000111_00001_00000_00100_01010_100000; //Instruction AND
		#10 instructionIn = 32'b000111_00001_00000_00100_01010_100101; //Instruction OR
		#10 instructionIn = 32'bx;
	end
	
endmodule
