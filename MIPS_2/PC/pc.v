module pc(
	input clk, rst,
	output reg [31:0] pc
);

always @(posedge clk or posedge rst) begin
	if (rst) 
		pc = 32'h1030; //grupo * 250h
	else 
		pc = pc + 1;
end

endmodule