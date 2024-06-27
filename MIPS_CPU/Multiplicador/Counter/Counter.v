module Counter(Clk, Load, K);
	input Clk;
	input Load;
	
	output reg K; 

	reg [5:0] cont;
	
	always @(posedge Clk, posedge Load) begin
		if (Load == 1'b1) 
		begin 
			cont <= 0;
			K <= 1'b0;
		end
		else 		
			case (cont)
			30: 
				K <= 1'b1;	
			
			default:
			begin
				cont <= cont + 1'b1; 
				K <= 1'b0; 
			end
			
			endcase
	end	
	
endmodule