module sumador_completo_verilog(
	input A, B,Ci,
	output Y, Co
	);
	   
	wire s_x1, s_a1, s_a2;   
	  
	assign s_x1 = A ^ B;
	assign Y = s_x1 ^ Ci;
	assign s_a1 = s_x1 & Ci;
	assign s_a2 = A & B;
	assign Co = s_a1 | s_a2;
	  
endmodule