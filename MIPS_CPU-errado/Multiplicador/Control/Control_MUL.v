module Control_MUL(Clk, St, K, M, Idle, Done, Load, Sh, Ad);
	input Clk;
	input St;
	input K;
	input M;
	
	output reg Idle;
	output reg Done;
	output reg Load;
	output reg Sh;
	output reg Ad;
	//output reg [1:0] Aux;
	
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
	
	reg [1:0] estAtual;	
	
	//Próximo estado
	always @(posedge Clk)
	begin
		case (estAtual)
		S0:
		begin
			if (St == 1) estAtual <= S1;
			else estAtual <= S0;
		end
		
		S1:
			estAtual <= S2;
		
		S2:
		begin
			if (K == 1) estAtual <= S3;
			else estAtual <= S1;
		end
		
		S3:
			estAtual <= S0;
		
		default:
		begin
			estAtual <= S0;
		end
		
		endcase
		
	end
	
	always @(*) 
	begin
		case (estAtual)
		S0:
		begin
			Ad = 0;
			Done = 0;
			Idle = 1;
			Sh = 0;
			if (St == 1) Load  = 1;
			else Load = 0;			
		end
		
		S1:
		begin
			Done = 0;
			Idle = 0;
			Load = 0;
			Sh = 0;
			if (M == 1) Ad = 1;
			else Ad = 0;
		end
		
		S2:
		begin
			Ad = 0;
			Done = 0;
			Idle = 0;
			Load = 0;
			Sh = 1;
		end
		
		S3:
		begin
			Ad = 0;
			Done = 1;
			Idle = 0;
			Load = 0;
			Sh = 0;
		end
		
		default:
		begin
			Ad = 0;
			Done = 0;
			Idle = 1;
			Load = 0;
			Sh = 0;			
		end
		
		endcase
	end
		
endmodule