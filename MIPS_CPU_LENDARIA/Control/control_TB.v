`timescale 1ns/100ps
module control_TB();

	reg  [31:0] instr;
	wire [4:0] a_reg;
	wire [4:0] b_reg;
	wire [23:0] ctrl;
	
	control DUT (instr, a_reg, b_reg, ctrl);
	
	initial begin
		//Formato i: code rs rt offset
		instr = 32'b001110_00001_00010_0100_0000_0000_0010; //LW
		#20 
		instr = 32'b001111_00001_00010_0000_0000_0000_0000; //SW
		#20
		
		//Formato R: code rs rt rd op
		instr = 32'b001101_00001_00010_00011_01010_100000; //ADD
		#20
		instr = 32'b001101_00001_00010_00011_01010_100010; //SUB
		#20
		instr = 32'b001101_00001_00010_00011_01010_110010; //MUL
		#20
		instr = 32'b001101_00001_00010_00011_01010_100100; //AND
		#20
		instr = 32'b001101_00001_00010_00011_01010_100101; //OR	
		#40
		$stop;
	end
	
endmodule
