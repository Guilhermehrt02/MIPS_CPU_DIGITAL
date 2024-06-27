module Counter (
	input Load,
	input Clk,
	output reg K
);

	reg [5:0] contagem;

	always @(posedge Clk) begin
		
		if (Load == 1) begin
			contagem = 0;
			K = 0;
		end
		
		else begin
			if (contagem == 30) begin
				K = 1;
			end
			
			else begin
				K = 0;
				contagem = contagem + 1;
			end
		end
	end
endmodule
