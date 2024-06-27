/*
a) Qual a latência do sistema?

	Desde a leitura da instrução da memória, até o write back no Register
	File, existe uma latência de 5 clicos.

b) Qual o throughput do sistema?

	O throughput maximo do sistema (quando não há bolhas) é de 1 instrução
	por ciclo.

c) Qual a máxima frequência operacional entregue pelo Time Quest Timing
Analizer para o multiplicador e para o sistema? (Indique a FPGA utilizada)

	TODO:
	FPGA: Cyclone IV GX EP4CGX150DF31C7,
		         | Slow 85C   | Slow 0C    | Fast 0C
	Sistema      | 109.66 MHz | 118.67 MHz | 201.01 MHz
	Multiplicador| 294.20 MHz | 320.82 MHz | 604.96 MHz

d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)

	Como o clock do sistema é 33 vezes menor que a do multiplicador,
	podemos alimentar o PLL do sistema com o clock máximo do
	multiplicardor, mesmo que o Time Quest reporte que a frequencia máxima
	deveria ser menor:

	FPGA: Cyclone IV GX EP4CGX150DF31C7,
		         | Slow 85C   | Slow 0C    | Fast 0C
	Sistema      | 8.9152 MHz | 9.7218 MHz | 18.332 MHz

e) Com a arquitetura implementada, a expressão (A*B) – (C+D) é executada
corretamente (se executada em sequência ininterrupta)? Por quê? O que pode ser
feito para que a expressão seja calculada corretamente?

	Não, porque há uma dependencia de dados entre a terceira instrução
	e as duas primeiras, porém as instruções possuem uma latência de
	4 ciclos entre a leitura dos registros e a escrita. Logo ocorre um
	pipeline hazzard.

	Logo é necessário reordenar as instruções (não é possível nesse caso) ou
	introduzir vazias (bubbles) para garantir que exista 4 instruções entre
	uma instrução e sua dependência.

f) Analisando a sua implementação de dois domínios de clock diferentes, haverá
problemas com metaestabilidade? Porquê?

	Não, pois os clocks estão sincronizados pela PLL, e a interação dos dois
	domínios só ocorre no ponto de sincronia dos dois.

g) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido,
é eficiente em termos de velocidade? Porquê?

	Não, pois do jeito que o multiplicador está integrado no sistema MIPS
	ele pode ser substituído por um multiplicador funcional, que, em termos
	puramente de velocidade, é mais rápido que o multiplicador multiciclos,
	que apresenta overheads.

h) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema
mais rápido (frequência de operação maior). Para cada modificação sugerida,
qual a nova latência e throughput do sistema?

	o bottleneck do sistema é o estágio de execução, que contém o
	Multiplicador. Logo melhorar o multiplicador é o que causará o maior
	impacto.

	Uma modificação seria substituir o multiplicador multiciclos por um
	multiplicador funcional, como já discutido na questão anterior. Isso não
	modificaria o latência e throughput do sitema, em termos de ciclos, mas
	diminuiria o tempo de clock, aumentando a frequência.

	Outra modificação mais complicada é tomar vantagem do multiplicador ser
	multiciclo, e fazer com que opere em paralelo ao pipeline. Isso
	permitira que o tempo de clock do sistema diminuisse em pelo menos 12
	vezes, porém introduziria mais pontos de hazzard de dados.
	Com essa modificão, o throughput e latência de instruções inteiras
	continuaria a mesma (em termos de número de ciclos), porém para as
	instruções de multiplicação, o throughput seria de 1 instrução a cada
	35 ciclos e uma latência de 37 ciclos (o estágio de execução duraria
	33 ciclos, e apenas os dois primeiros estágios estariam em paralelo).
*/
module cpu (
	input CLK, RST,
	input [31:0] Prog_BUS_READ,
	input [31:0] Data_BUS_READ,
	output [31:0] ADDR, 
	output CS, CS_P, WR_RD,
	output [31:0] Data_BUS_WRITE
);

(*keep=1*) wire CLK_SYS;
(*keep=1*) wire CLK_MUL, pll_locked, RST_SYS;
wire sync_mul1, sync_mul;
assign RST_SYS = RST || !pll_locked; 
wire idle, done;

// Primeiro Estágio
// Instruction Fetch

pll PLL(
	RST,
	CLK,
	CLK_MUL,
	CLK_SYS,
	pll_locked
);

Register #(1) SYNC_MUL1(
	CLK_SYS, RST_SYS,
	pll_locked, sync_mul1
);
Register #(1) SYNC_MUL(
	CLK_SYS, RST_SYS,
	sync_mul1, sync_mul
);



(*keep=1*) wire [31:0] instr;
(*keep=1*) wire [31:0] ADDR_Prog;
wire [31:0] IntstructionOut;

pc PC(
	CLK_SYS, RST_SYS,
	ADDR_Prog
);

instructionmemory InstructionMemory(
	ADDR_Prog[9:0],
	CLK_SYS,
	IntstructionOut
);

mux MuxMemoryProg(
	IntstructionOut,
	CS_P, Prog_BUS_READ,
	instr
);

ADDRDecoding_Prog ADDRDecodingProg(
	ADDR_Prog,
	CLK_SYS,
	CS_P
);

//	Segundo Estágio
// Instruction Decode

(*keep=1*) wire [31:0] writeBack;
wire writeBack_en;
wire [4:0] writeBack_reg;
//wire [4:0] a_reg, b_reg;
wire [31:0] wire_a, wire_b, imm_in;
wire [31:0] wire_a_out, wire_b_out, imm;
wire[19:0] ctrl_in;
(*keep=1*) wire[11:0] ctrl;

registerfile RegisterFile(
	CLK_SYS, 
	RST_SYS,
	writeBack_en, 
	ctrl_in[17:13], 
	ctrl_in[13:9],
	writeBack_reg, 
	writeBack,
	wire_a, 
	wire_b
);

control Control(
	instr, ctrl_in
);

extend Extend(
	instr,
	imm_in
);

Register A(
	CLK_SYS, RST_SYS,
	wire_a, wire_a_out
);

Register B(
	CLK_SYS, RST_SYS,
	wire_b, wire_b_out
);

Register IMM(
	CLK_SYS, RST_SYS,
	imm_in, imm
);


Register #(12) CTRL1(
	CLK_SYS, RST_SYS,
	ctrl_in, ctrl
);


// Terceiro Estágio
// Execute

wire [31:0] mul, op, c_out, d_out, d_mem, b_mem;
wire c_sel, d_sel;
wire [1:0] op_sel;
wire [7:0] ctrl_mem_in;
wire [7:0] ctrl_mem;
assign { c_sel, d_sel, op_sel, ctrl_mem_in } = ctrl;

//Clk, St, Done, Idle, Multiplicando, Multiplicador, Produto
multiplicador MULT(
	CLK_MUL,
	sync_mul,
	done,
	idle,
	wire_a_out[15:0], wire_b_out[15:0],
	mul
);

//select, A, B, outputMux
mux Mux_Alu_In(
	c_sel,
	wire_b_out, imm,
	c_out
);

//select, A, B, result
ALU ALU(
	op_sel,
	wire_a_out, c_out,
	op
);

//select, A, B, outputMux
mux Mux_Alu_Out (
	d_sel,
	mul, op,
	d_out
);

//Clk, reset, regIn, regOut
Register D(
	CLK_SYS, RST_SYS,
	d_out, d_mem
);

Register B2(
	CLK_SYS, RST_SYS,
	wire_b_out, b_mem
);

Register #(8) CTRL2(
	CLK_SYS, RST_SYS,
	ctrl_mem_in, ctrl_mem
);

// Quarto Estágio
// Memory

wire [31:0] wire_d2_out, m_wb;
wire rd_wr;
wire [6:0] ctrl_wb_in; wire [7:0] ctrl_wb;
assign { rd_wr, ctrl_wb_in } = ctrl_mem;
assign WR_RD = !rd_wr;
assign ADDR = d_mem;
assign Data_BUS_WRITE = b_mem;

ADDRDecoding ADDRDecoding(
	ADDR,
	CS
);

/*clk, 
	ADDR,          // endereco de memoria
 	din,      // entrada da memoria
 	WR_RD,
	cs,
 	dout      // saida da memoria */
datamemory DataMemory(
	CLK_SYS,
	{ ADDR[9:0] },
	Data_BUS_WRITE, 
	WR_RD, 
	RST_SYS,
	m_wb
);

Register D2(
	CLK_SYS, RST_SYS,
	d_mem, wire_d2_out
);

Register #(8) CTRL3(
	CLK_SYS, RST_SYS,
	{ CS, ctrl_wb_in }, ctrl_wb
);

// Quinto Estágio
// Write Back

wire wb_sel, cs_wb;
wire [31:0] wire_m_out;
assign { cs_wb, wb_sel, writeBack_en, writeBack_reg } = ctrl_wb;

//select, A, B, outputMux
mux M(
	cs_wb,
	m_wb, Data_BUS_READ,
	wire_m_out
);

mux MUX_WB(
	wb_sel,
	wire_d2_out, wire_m_out,
	writeBack
);

endmodule
