module instructionmemory(
	input clk,
	input[9:0] pc,
	output reg[31:0] ins_out
);

	parameter n_words = 1024;
	parameter word_size = 32;

	//1KWord de memoria de instrucao, Word = 32 bits
	reg [word_size-1:0] ins_mem [0:n_words-1];

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
	parameter n10 = 5'd9; //Numero 9
	parameter ng = 6'd9;  //Numero do grupo 9
	parameter n11 = 6'd10; //Numero do grupo + 1 = 10
	parameter n12 = 6'd11; //Numero do grupo + 2 = 11
	
	//Operacoes
	parameter add = 6'd32;
	parameter sub = 6'd34;
	parameter mul = 6'd50;
	parameter nop = 6'd1;
	
	//Endereco das variaveis
	parameter end_a = 16'h1DD0;
	parameter end_b = 16'h1DD1;
	parameter end_c = 16'h1DD2;
	parameter end_d = 16'h1DD3;
	
	//Ultimo endereco de memoria
	parameter ultimo_end = 16'h21CF;

	integer i;
	
	initial begin
		// Codigo com pipeline hazzard.
		ins_mem[0]  = {n11,r0,r1,end_a};      //R1<-A (LW)
		ins_mem[1]  = {n11,r0,r2,end_b};      //R2<-B (LW)
		ins_mem[2]  = {n11,r0,r3,end_c};      //R3<-C (LW)
		ins_mem[3]  = {n11,r0,r4,end_d};      //R4<-D (LW)
		ins_mem[4]  = {ng,r2,r1,r5,n10,sub}; //R5<-B-A (MUL)
		ins_mem[5]  = {ng,r3,r4,r6,n10,sub}; //R6<-C-D (ADD)
		ins_mem[6]  = {ng,r5,r6,r7,n10,mul}; //R7<-R5*R6 (SUB)
		ins_mem[7]  = {n12,r7,r7,ultimo_end}; //ARMAZENA ULT. POS. (SW)
		
	
		// Codigo com bolhas.
		ins_mem[8]  = {n11,r0,r1,end_a};      //R1<-A (LW)
		ins_mem[9]  = {n11,r0,r2,end_b};      //R2<-B (LW)
		ins_mem[10] = {n11,r0,r3,end_c};      //R3<-C (LW)
		ins_mem[11] = {n11,r0,r4,end_d};      //R4<-D (LW)
		ins_mem[12] = {ng,r0,r0,r0,n10,nop}; //NOP
		ins_mem[13] = {ng,r2,r1,r5,n10,sub}; //R5<-B-A (MUL)
		ins_mem[14] = {ng,r0,r0,r0,n10,nop}; //NOP
		ins_mem[15] = {ng,r3,r4,r6,n10,sub}; //R6<-C-D (ADD)
		ins_mem[16] = {ng,r0,r0,r0,n10,nop}; //NOP
		ins_mem[17] = {ng,r0,r0,r0,n10,nop}; //NOP
		ins_mem[18] = {ng,r0,r0,r0,n10,nop}; //NOP
		ins_mem[19] = {ng,r5,r6,r7,n10,mul}; //R7<-R5*R6 (SUB)
		ins_mem[20] = {ng,r0,r0,r0,n10,nop}; //NOP
		ins_mem[21] = {ng,r0,r0,r0,n10,nop}; //NOP
		ins_mem[22] = {ng,r0,r0,r0,n10,nop}; //NOP
		ins_mem[23] = {n12,r7,r7,ultimo_end}; //ARMAZENA ULT. POS. (SW)
		
	end

	always @(posedge clk)
		ins_out = ins_mem[pc];

endmodule
