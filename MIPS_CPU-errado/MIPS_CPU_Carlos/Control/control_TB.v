`timescale 1ns/10ps
module control_TB();

	integer i;
	reg[31:0] ins_mem [0:7];
	reg[31:0] instruction;
	wire[31:0] control_out;

	//Registros
	parameter r0 = 5'd0;
	parameter r1 = 5'd1;
	parameter r2 = 5'd2;
	parameter r3 = 5'd3;
	parameter r4 = 5'd4;
	parameter r5 = 5'd5;
	parameter r6 = 5'd6;
	parameter r7 = 5'd7;
	parameter r8 = 5'd8;
	
	//Numeros
	parameter n10 = 5'd10; //Numero 10
	parameter n14 = 6'd9; //Numero do grupo
	parameter n15 = 6'd10; //Numero do grupo + 1
	parameter n16 = 6'd11; //Numero do grupo + 2
	
	//Operacoes
	parameter add = 6'd32;
	parameter sub = 6'd34;
	parameter mul = 6'd50;
	parameter nop = 6'd63;
	
	//Endereco das variaveis
	parameter end_a = 16'h1dd0;
	parameter end_b = 16'h1dd1;
	parameter end_c = 16'h1dd2;
	parameter end_d = 16'h1dd3;
	
	//Ultimo endereco de memoria
	parameter ultimo_end = 16'h21cf;

	control DUT(
		.instruction(instruction),
		.control_out(control_out)
	);

	initial begin
		ins_mem[0] = {n15,r0,r1,end_a};      //R1<-A     
		ins_mem[1] = {n15,r0,r2,end_b};      //R2<-B
		ins_mem[2] = {n15,r0,r3,end_c};      //R3<-C
		ins_mem[3] = {n15,r0,r4,end_d};      //R4<-D
		ins_mem[4] = {n14,r2,r1,r5,n10,sub}; //R5<-B-A
		ins_mem[5] = {n14,r3,r4,r6,n10,sub}; //R6<-C-D
		ins_mem[6] = {n14,r5,r6,r7,n10,mul}; //R7<-R5*R6
		ins_mem[7] = {n16,r7,r7,ultimo_end}; //SW
		
		//Control OUT:
		//00000 00000 00001 10000110000000000
		//00000 00000 00010 10000110000000000
		//00000 00000 00011 10000110000000000
		//00000 00000 00100 10000110000000000
		//
		//00001 00010 00101 00000011000000000
		//00011 00100 00110 00000010000000000
		//00101 00110 00111 00010010000000000
		//
		//00111 00111 00000 10001100000000000

		for(i=0;i<8;i=i+1)
			#100 instruction = ins_mem[i];

		#1000 $stop;
	end

	always #80 $display("%d %d %b", instruction[31:26], instruction[5:0], control_out);

endmodule