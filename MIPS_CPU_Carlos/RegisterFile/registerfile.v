module registerfile(
	input clk,
	input rst,
	input[31:0] data_in, //Entrada de dados
	input[4:0] sel_r_in, //Seleciona registrador de entrada
	input we,            //write on register enable
	input[4:0] sel_r_a,  //Seleciona registrador de saida A
	input[4:0] sel_r_b,  //Seleciona registrador de saida B
	output reg[31:0] ra, //Saida A
	output reg[31:0] rb  //Saida B
);

	//32 registradores
	reg[31:0]s0;reg[31:0]s1;reg[31:0]s2;reg[31:0]s3;reg[31:0]s4;
	reg[31:0]s5;reg[31:0]s6;reg[31:0]s7;reg[31:0]t0;reg[31:0]t1;
	reg[31:0]t2;reg[31:0]t3;reg[31:0]t4;reg[31:0]t5;reg[31:0]t6;
	reg[31:0]t7;

	//Inicializa eles como zero
	initial begin
		s0=0;s1=0;s2=0;s3=0;s4=0;s5=0;s6=0;s7=0;
		t0=0;t1=0;t2=0;t3=0;t4=0;t5=0;t6=0;t7=0;
	end

	always @(posedge clk) begin
	
		if (~rst) begin
			s0=0;s1=0;s2=0;s3=0;s4=0;s5=0;s6=0;s7=0;
			t0=0;t1=0;t2=0;t3=0;t4=0;t5=0;t6=0;t7=0;
		end 
		
		else if (we) begin
			case(sel_r_in)
				0:  s0 = data_in;
				1:  s1 = data_in;
				2:  s2 = data_in;
				3:  s3 = data_in;
				4:  s4 = data_in;
				5:  s5 = data_in;
				6:  s6 = data_in;
				7:  s7 = data_in;
				8:  t0 = data_in;
				9:  t1 = data_in;
				10: t2 = data_in;
				11: t3 = data_in;
				12: t4 = data_in;
				13: t5 = data_in;
				14: t6 = data_in;
				15: t7 = data_in;
			endcase
		end
		
		case(sel_r_a)
			0:  ra = s0;
			1:  ra = s1;
			2:  ra = s2;
			3:  ra = s3;
			4:  ra = s4;
			5:  ra = s5;
			6:  ra = s6;
			7:  ra = s7;
			8:  ra = t0;
			9:  ra = t1;
			10: ra = t2;
			11: ra = t3;
			12: ra = t4;
			13: ra = t5;
			14: ra = t6;
			15: ra = t7;
		endcase
		
		case(sel_r_b)
			0:  rb = s0;
			1:  rb = s1;
			2:  rb = s2;
			3:  rb = s3;
			4:  rb = s4;
			5:  rb = s5;
			6:  rb = s6;
			7:  rb = s7;
			8:  rb = t0;
			9:  rb = t1;
			10: rb = t2;
			11: rb = t3;
			12: rb = t4;
			13: rb = t5;
			14: rb = t6;
			15: rb = t7;
		endcase
		
	end

endmodule
