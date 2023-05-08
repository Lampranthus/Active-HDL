parameter 	N=4;

module restador_n_verilog
	
	(
	input [N-1:0]A, [N-1:0]B,
	output [N-1:0]R
	);
	
	var signed [N:0]resta;
	
	assign resta = A + ~B + 1;
	assign R = resta [N-1:0];
	
endmodule
	
	
