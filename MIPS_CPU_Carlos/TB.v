`timescale 1ns/10ps
module TB();

	reg clock;
	
	reg reset;
	reg[31:0] Data_BUS_READ;
	reg[31:0] Prog_BUS_READ;
	wire[31:0] Data_BUS_WRITE;
	wire[31:0] ADDR;
	wire[31:0] ADDR_Prog;
	wire CS;
	wire CS_P;
	wire WR_RD;
	
	reg CLK_MUL;
	reg CLK_SYS;
	reg [31:0] WriteBack;

	cpu DUT (
		.CLK(clock),
		.reset(reset),
		.Data_BUS_READ(Data_BUS_READ),
		.ADDR(ADDR),
		.ADDR_Prog(ADDR_Prog),
		.Data_BUS_WRITE(Data_BUS_WRITE),
		.Prog_BUS_READ(Prog_BUS_READ),
		.CS(CS),
		.CS_P(CS_P),
		.wr_rd(WR_RD)
	);

	initial begin
		$init_signal_spy("/TB/DUT/CLK_MUL", "CLK_MUL", 1);
		$init_signal_spy("/TB/DUT/CLK_SYS", "CLK_SYS", 1);
		$init_signal_spy("/TB/DUT/MUX_WB", "WriteBack", 1);
		Data_BUS_READ = 32'h21CF;
		Prog_BUS_READ = 32'h18CF;
		clock = 0;
		reset = 0;
		#100 reset = 1;
		#1234600 $stop;
	end

	always #10 clock = ~clock;

endmodule
