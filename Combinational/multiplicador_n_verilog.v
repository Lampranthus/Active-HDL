parameter N = 9;

module multiplicador_n_verilog(
	
	input [N-1:0]A, [N-1:0]B,
	output [2*N-1:0]M 
	
	);
	
	var signed [2*N-1]mul;
	
	assign mul = A * B;
	assign M = mul;
	
endmodule