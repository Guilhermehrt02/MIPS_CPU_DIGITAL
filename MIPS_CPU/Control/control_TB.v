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
		instructionIn = 32'hC600001; //Instruction LW s0, 1(s3)
		#10 instructionIn = 32'h1025000A; //Instruction SW s5, 10(s1)
		#10 instructionIn = 32'h8A71AA0; //Instruction ADD s3, s5, s7
		#10 instructionIn = 32'h88D52A2; //Instruction SUB t2, s4, t5
		#10 instructionIn = 32'h8A822B2; //Instruction MUL s4, s5, t0
		#10 instructionIn = 32'h94B4AA4; //Instruction AND t1, t2, t3
		#10 instructionIn = 32'h8C16AA5; //Instruction OR t5, s6, s1	
		#10 instructionIn = 32'bx;
	end
	
endmodule
