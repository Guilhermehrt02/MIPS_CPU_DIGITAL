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
wire [31:0] InstructionOut;

pc PC(
    CLK_SYS, RST_SYS,
    ADDR_Prog
);

instructionmemory InstructionMemory(
    ADDR_Prog[9:0],
    CLK_SYS,
    InstructionOut
);

mux MuxMemoryProg(
    CS_P, InstructionOut, Prog_BUS_READ,
    instr
);

ADDRDecoding_Prog ADDRDecodingProg(
    ADDR_Prog,
    CLK_SYS,
    CS_P
);

// Segundo Estágio
// Instruction Decode

(*keep=1*) wire [31:0] writeBack;
wire writeBack_en;
wire [4:0] writeBack_reg;
wire [31:0] wire_a, wire_b, imm_in;
wire [31:0] wire_a_out, wire_b_out, imm;
wire [19:0] ctrl_in;
(*keep=1*) wire [11:0] ctrl;

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

mux Mux_Alu_In(
    c_sel, wire_b_out, imm,
    c_out
);

ALU ALU(
    op_sel, wire_a_out, c_out,
    op
);

mux Mux_Alu_Out (
    d_sel, mul, op,
    d_out
);

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
wire [6:0] ctrl_wb_in; 
wire [7:0] ctrl_wb;
assign { rd_wr, ctrl_wb_in } = ctrl_mem;
assign WR_RD = !rd_wr;
assign ADDR = d_mem;
assign Data_BUS_WRITE = b_mem;

ADDRDecoding ADDRDecoding(
    ADDR,
    CLK_SYS,
    CS
);

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

mux M(
    cs_wb, m_wb, Data_BUS_READ,
    wire_m_out
);

mux MUX_WB(
    wb_sel, wire_d2_out, wire_m_out,
    writeBack
);

endmodule