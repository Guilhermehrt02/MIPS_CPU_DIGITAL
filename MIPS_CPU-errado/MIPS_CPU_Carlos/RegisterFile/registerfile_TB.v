`timescale 1ns/10ps
module registerfile_TB();

	reg clk;
	reg rst;
	reg[31:0] data_in;
	reg[4:0] sel_r_in;
	reg we;
	reg[4:0] sel_r_a;
	reg[4:0] sel_r_b;
	wire [31:0] ra;
	wire [31:0] rb;

	registerfile RegisterFile(
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.sel_r_in(sel_r_in),
		.we(we),
		.sel_r_a(sel_r_a),
		.sel_r_b(sel_r_b),
		.ra(ra),
		.rb(rb)
	);

	//Condicoes iniciais
	initial begin
		clk = 0;
		rst = 0;
		data_in = 0;
		sel_r_in = 0;
		we = 0;
		sel_r_a = 0;
		sel_r_b = 0;
	end

	//Clock com periodo de 100ns
	always #50 clk = ~clk;

	integer i;

	initial begin

		//Retira o reset depois de 500ns
		#500 rst = 1;
		
		//Escreve 55 em todos registradores
		data_in = 55;
		we = 1;
		for(i=0;i<16;i=i+1) begin
			sel_r_in = i;
			#100;	 
		end

		//Tenta escrever quando o registrador esta em modo leitura
		data_in = 110;
		we = 0;
		for(i=0;i<16;i=i+1) begin
			sel_r_in = i;
			sel_r_a = i;
			sel_r_b = i;
			#100;
		end

		#100 $stop;
	end

	always #100 $display("%b %d %d %d %d %d",rst, data_in, we, sel_r_in, sel_r_a, sel_r_b, ra, rb);

endmodule
