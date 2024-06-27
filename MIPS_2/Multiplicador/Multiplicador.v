module Multiplicador (
	output [31:0] resul,
	input [15:0] M1, M2,
	input St,
	input clk, rst
);
wire Load, Sh, Ad, K;
wire[16:0] Soma;
wire[32:0] Saidas;
assign resul = Saidas[31:0];

CONTROL control (Load, Sh, Ad, clk, K, resul[0], St, rst);
Counter counter (K, Load, clk, rst);
Adder adder (Soma, M1, resul[31:16]);
ACC acc (Saidas,Soma, M2, M1,Load, Sh, Ad, clk, rst);

endmodule
