module ALU(select, A, B, result);
	input [1:0] select;
	input [31:0] A;
	input [31:0] B;
	
	output reg [31:0] result;
	
	always @(*)
	begin
		case (select)
			0: //Soma
				result <= A + B;
			1: //Subtracao
				result <= A - B;
			2: //And
				result <= A & B;
			3: //Or
				result <= A | B;
			default:
				result <= 32'b0;
		endcase
	end
	
endmodule 