module datamemory
#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 10)
(
	input [(DATA_WIDTH-1):0] din,
	input [(ADDR_WIDTH-1):0] ADDR,
	input WR_RD, clk, rst,
	output [(DATA_WIDTH-1):0] dout
);

reg [DATA_WIDTH-1:0] mem[1023:0];
reg [ADDR_WIDTH-1:0] ADDR_Reg;
integer i;

initial begin
	for (i = 0; i < 1023; i = i + 1) begin
		mem[i] = 0;
	end
	mem[0] = 2001;
	mem[1] = 4001;
	mem[2] = 5001;
	mem[3] = 3001;
end

always @ (posedge clk or posedge rst) begin
	if(rst)
		ADDR_Reg <= 0;
	else begin	
		if (WR_RD == 0)
			mem[ADDR] <= din;

		ADDR_Reg <= ADDR + 10'hF0;
	end
end

assign dout = mem[ADDR_Reg];

endmodule

