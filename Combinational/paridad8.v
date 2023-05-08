module paridad8( 
	
	input [7:0]D,
	output reg Y 
	
	);
	
	wire s_d76, s_d54, s_d32, s_d10, s_d7654, s_d3210;
	
	assign s_d76	=	D[7] ^ D[6];
	assign s_d54	=	D[5] ^ D[4];
	assign s_d32	=	D[3] ^ D[2];
	assign s_d10	=	D[1] ^ D[0];
	
	assign s_d7654	=	s_d76 ^ s_d54;
	assign s_d3210	=	s_d32 ^ s_d10;
	
	assign Y	=	s_d7654 ^ s_d3210;
	
endmodule