/*
Grupo 9:
Samuel SIqueira Ferreira-2018010038

-------------------------------------------------------------------------------------------------------------------------------------------------------
											RESPOSTAS
	
	A) Qual a latência do sistema?
	
	R: A latência do sistema é de cinco períodos de clock,pois há 5 estágios de pipeline.
	
	B) Qual o throughput do sistema?
	
	R: O Throughput do sistema é de uma instrução de 32 bits/período de clock, isso se o pipeline do Mips estiver completamente carregado.
	
	C) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer para o multiplicador
	e para o sistema? (Indique a FPGA utilizada)

	R: FPGA:  Cyclone IV GX EP4CGX150DF31I7AD
		Multiplicador: 248.14 MHz.(Slow 1200mV 100C Model)
		Sistema: 61.81 MHz. (Slow 1200mV 100C Model)
	
	D) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada) 
	
	R: FPGA:  Cyclone IV GX EP4CGX150DF31I7AD
		Máx System = Frequência Multiplicador / 34
		Máx System = (248.14 MHz/34)(Slow 1200mV 100C Model) = 7,298 MHz   
	
	E) Com a arquitetura implementada, a expressão (B-A) * (C-D) é executada corretamente
	(se executada em sequência ininterrupta)? Por quê? O que pode ser feito para que a expressão seja
	calculada corretamente?
		
	R: A expressão (B-A) * (C-D) não produzirá o resultado esperado se executada sequencialmente e sem interrupções, devido aos seguintes fatores:

	1-Quando a operação de load do B estiver no último estágio do pipeline MIPS, a subtração (B-A) estará apenas no segundo estágio. Assim, no próximo 
	ciclo de clock, o valor de B será solicitado, mas ainda não terá sido carregado.
	
	2-Na implementação do RegFile, foi utilizada uma flag para garantir a segurança dos dados, o que impede operações simultâneas de leitura e escrita. 
	Portanto, quando uma instrução que escreve no RegFile estiver no quinto estágio, uma instrução no segundo estágio não poderá solicitar um valor do 
	registro.
	
	F) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas com 
	metaestabilidade?  Por que?

	Não haverá problemas de metaestabilidade, pois a PLL assegura que os valores das operações, especialmente da multiplicação, estejam estáveis no 
	próximo ciclo de clock do sistema. Isso ocorre porque o sistema opera a uma frequência 34 vezes menor que a do multiplicador
	
	
	G) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, é eficiente em termos
	de velocidade? Por que?

	R: Não, porque o multiplicador utilizado requer 34 ciclos de clock para retornar o produto. Portanto, o clock do sistema deve ser 34 vezes menor 
	para que a operação seja efetuada corretamente. Isso limita o sistema a uma frequência máxima de 7,298 MHz, que é significativamente menor 
	que a frequência máxima de 61,81 MHz, conforme reportado pelo Timming Analyser.
	
	H) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais rápido (frequência
	de operação maior). Para cada modificação sugerida, qual a nova latência e throughput do sistema?
	
	R: Uma modificação possível seria utilizar o multiplicador nativo da FPGA ou um algoritmo mais eficiente para essa operação. Embora a latência e 
	o throughput do sistema permaneçam os mesmos, a frequência do sistema não precisaria ser 34 vezes menor que a do multiplicador. Assim, seria 
	possível adotar uma frequência próxima à máxima de operação do multiplicador da FPGA ou do algoritmo mais eficiente.
	
	*/
	
	
module cpu(
	input CLK,
	input reset,
	output[31:0] ADDR,
	output[31:0] ADDR_Prog,
	input [31:0] Data_BUS_READ,
	input [31:0] Prog_BUS_READ,
	output[31:0] Data_BUS_WRITE,
	output wr_rd,
	output CS,
	output CS_P
);

	wire cs;
	wire cs_P;
	wire idle;
	wire done;
	wire locked;
	(*keep=1*)wire CLK_MUL;
	(*keep=1*)wire CLK_SYS;
	
	wire[31:0] INS_MEM_ADDR;
	wire[31:0] INST_IF_ID;
	wire[31:0] IMM_ID_EX;
	wire[31:0] CTRL;
	wire[31:0] W_CTRL_ID_EX;
	wire[31:0] W_CTRL_EX_MEM;
	wire[31:0] W_CTRL_MEM_WB;
	wire[31:0] A_ID_EX;
	wire[31:0] B_ID_EX;
	wire[31:0] MUX1_ALU;
	wire[31:0] MUX5_INST;
	wire[31:0] MUX3_MUX2;
	(*keep=1*)wire[31:0] MUX_WB;
	wire[31:0] MUX4_REGD1;
	wire[31:0] ALU_REGD1;
	wire[31:0] MUL_OUT;
	wire[31:0] REGD1_REGD2;
	wire[31:0] REGB_MEM;
	wire[31:0] REGD2_WB;
	wire[31:0] MEM_MUX3;
	wire[31:0] MUX5_control;

	assign ADDR = REGD1_REGD2;
	assign Data_BUS_WRITE = REGB_MEM;
	assign wr_rd = W_CTRL_EX_MEM[12];
	assign CS = cs;
	assign ADDR_Prog = INS_MEM_ADDR;
	assign CS_P = cs_P; 
	// PLL
	PLL PLL_0(1'b0,CLK,CLK_SYS, CLK_MUL, locked);
	
	// PC
	pc pc_0(reset, CLK_SYS, INS_MEM_ADDR);
	
	// INSTRUCTION MEMORY
	instructionmemory ins_mem_0(CLK_SYS, INS_MEM_ADDR, INST_IF_ID);
	
	// ADDR DECODING
	ADDRDecoding_Prog addr_prog_0(CLK_SYS, INS_MEM_ADDR, cs_P);
	
	//MUX5
	mux MUX5(INST_IF_ID,Prog_BUS_READ,cs_P,MUX5_control);
	
	// CONTROL
	control control_0(MUX5_control, CTRL);
	
	// EXTEND
	extend ext_0(CLK_SYS, reset, INST_IF_ID[15:0], IMM_ID_EX);
	
	// REGISTER FILE
	registerfile reg_file_0(
		CLK_SYS,
		reset,
		MUX_WB,
		W_CTRL_MEM_WB[21:17],
		W_CTRL_MEM_WB[10],
		CTRL[31:27],
		CTRL[26:22],
		A_ID_EX,
		B_ID_EX
	);
	
	// MUX 1
	mux MUX1(B_ID_EX, IMM_ID_EX, W_CTRL_ID_EX[16], MUX1_ALU);
	// ALU
	alu alu_0(A_ID_EX, MUX1_ALU, W_CTRL_ID_EX[15:13], ALU_REGD1);
	// ADDR DECODING
	ADDRDecoding addr_dec_0(CLK_SYS,REGD1_REGD2, cs);
	// MUX 3
	mux MUX3(MEM_MUX3,Data_BUS_READ,cs,MUX3_MUX2);
	// MULTIPLICADOR
	multiplicador mul_0(MUL_OUT,done,idle,A_ID_EX, B_ID_EX,W_CTRL_ID_EX[9],CLK_MUL,~reset);
	//MUX 4
	mux MUX4(ALU_REGD1 , MUL_OUT , W_CTRL_ID_EX[9] , MUX4_REGD1);
	// DATA MEMORY
	datamemory d_mem_0(REGD1_REGD2[9:0], REGB_MEM, MEM_MUX3, CLK_SYS, W_CTRL_EX_MEM[12]);
	// MUX 2
	mux MUX2(REGD2_WB, MUX3_MUX2, W_CTRL_MEM_WB[11], MUX_WB);
	// REGISTROS
	Register CTRL_ID_EX(CLK_SYS, reset, CTRL, W_CTRL_ID_EX);
	Register CTRL_EX_MEM(CLK_SYS, reset, W_CTRL_ID_EX, W_CTRL_EX_MEM);
	Register CTRL_MEM_WB(CLK_SYS, reset, W_CTRL_EX_MEM, W_CTRL_MEM_WB);
	Register REGB(CLK_SYS, reset, B_ID_EX, REGB_MEM);
	Register REGD1(CLK_SYS, reset, MUX4_REGD1, REGD1_REGD2);
	Register REGD2(CLK_SYS, reset, REGD1_REGD2, REGD2_WB);

endmodule