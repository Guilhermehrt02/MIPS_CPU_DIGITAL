`timescale 1ns/10ps
module mux_TB();

	reg[31:0] a;
	reg[31:0] b;
	reg sel;
	wire[31:0] mux_out;

	mux DUT(
		.a(a),
		.b(b),
		.sel(sel),
		.mux_out(mux_out)
	);

	initial begin
		sel = 0;
		a = 32'hFFFF0000;
		b = 32'h0000FFFF;
		#100	sel = 1;
		#100 $stop;
	end

endmodule
