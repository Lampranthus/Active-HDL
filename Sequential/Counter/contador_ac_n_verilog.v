parameter n=4;

module contador_ac_n_verilog (
	input RST,CLK,x0,
	output reg [n-1:0]Q
	);
	
	always @ (posedge CLK, posedge RST)
	begin
		if(RST==0)
			Q <= 0;
		else
			case(x0)
				0 : Q <= Q + 1;
				1 : Q <= Q - 1;
			endcase
	end
endmodule