module sumador4b_verilog(
	input [3:0]a, [3:0]b, 
	input Ci,
	
	output [4:0]Y, 
	output Co // solo como referencia, se utiliza Y[4] como salida del ultimo bit de acarreo para mostrar una simulacion mas comprensible 
	
	); 
	
	wire b_0, b_1, b_2;
	
	sumador_completo_verilog sumador1 (a[0],b[0],Ci,Y[0],b_0);
	sumador_completo_verilog sumador2 (a[1],b[1],b_0,Y[1],b_1);
	sumador_completo_verilog sumador3 (a[2],b[2],b_1,Y[2],b_2);
	sumador_completo_verilog sumador4 (a[3],b[3],b_2,Y[3],Y[4]);
	
	
endmodule