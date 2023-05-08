
module contador_adhb_n_verilog
#(	parameter n=4,
	parameter l=4)
(
	input RST,CLK,
	input [1:0]s,
	output reg [l-1:0]q
	);
	
	reg [n-1:0]qp,qn;
	
	always @ (qp,s)
		begin
			case(s)
				0 : qn <= qp + 1;
				1 : qn <= qp - 1;
				2 : qn <= qp;
				3 : qn <= 0;
			endcase
			
			q = qp[n-1:n-l];
			
		end
	
	always @ (posedge CLK)
	begin
		if(RST==0)
			qp <= 0;
		else
			qp <= qn;	
	 end
endmodule