parameter N=4;

module Sumador_n_verilog(
	input [N-1:0]A,[N-1:0]B,
	input Ci,
	output [N-1:0]S,
	output Co
	);
	
	var unsigned [N:0]suma;
	
	assign suma = A + B + Ci;
	assign S = suma[N-1:0];
	assign Co = suma[N];

endmodule