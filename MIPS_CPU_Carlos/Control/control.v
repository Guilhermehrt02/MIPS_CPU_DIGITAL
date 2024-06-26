module control(
	input[31:0] instruction,
	output reg[31:0] control_out
);

	reg[4:0] rd;
	reg[4:0] rs;
	reg[4:0] rt;

	always@(*) begin

		//Instrucoes que comecam com Grupo (9)
		if(instruction[31:26] == 6'd9) begin
		
			//ADD
			if (instruction[5:0]==32) begin
				rs = instruction[25:21];
				rt = instruction[20:16];
				rd = instruction[15:11];
				control_out = {rs,rt,rd,17'b00000010000000000};
			end
			
			//SUB
			else if (instruction[5:0]==34) begin
				rs = instruction[25:21];
				rt = instruction[20:16];
				rd = instruction[15:11];
				control_out = {rs,rt,rd,17'b00010010000000000};
			end	
			
			//AND
			else if (instruction[5:0]==36) begin
				rs = instruction[25:21];
				rt = instruction[20:16];
				rd = instruction[15:11];
				control_out = {rs,rt,rd,17'b00100010000000000};
			end
			
			//OR
			else if (instruction[5:0]==37) begin
				rs = instruction[25:21];
				rt = instruction[20:16];
				rd = instruction[15:11];
				control_out = {rs,rt,rd,17'b00110010000000000};
			end	
			
			//MUL
			else if (instruction[5:0]==50) begin
				rs = instruction[25:21];
				rt = instruction[20:16];
				rd = instruction[15:11];
				control_out = {rs,rt,rd,17'b00000011000000000};
			end	
			
			//NOP
			else begin
				rs = 0;
				rt = 0;
				rd = 0;
				control_out = {rs,rt,rd,17'b00000000000000000};
			end
		end 
		
		//Grupo+1 (10) LW
		else if (instruction[31:26] == 6'd10) begin
			rs = instruction[25:21];
			rt = 0;
			rd = instruction[20:16];
			control_out = {rs,rt,rd,17'b10000110000000000};
		end 
		
		//Grupo+2 (11) SW
		else if (instruction[31:26] == 6'd11) begin
			rs = instruction[25:21];
			rt = instruction[20:16];
			rd = 0;
			control_out = {rs,rt,rd,17'b10001100000000000};
		end
		
		else begin
			rs = 0;
			rt = 0;
			rd = 0;
			control_out = 32'b00000000000000000000000000000000;
		end
	end
endmodule
