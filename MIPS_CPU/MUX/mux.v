module mux(
	input [31:0] a, b,
	input seletor,
	output [31:0] out
);

assign out = seletor ? b : a;

endmodule

