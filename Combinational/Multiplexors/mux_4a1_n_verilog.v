parameter N=2;

module mux_4a1_n_verilog(
	input [N-1:0]A,[N-1:0]B,[N-1:0]C,[N-1:0]D,
	input [1:0]S,
	output reg [N-1:0]Y
	);
	
	always @ (A,B,C,D,S)
		case(S)
			0: Y=A;
			1: Y=B;
			2: Y=C;
			3: Y=D;
		endcase
endmodule