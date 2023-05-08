module SHR_v
	#(parameter N = 8)
	
	(
	input rst,clk,l,
	input [1:0]opr,
	output reg [N-1:0]q
	);
	
	reg [N-1:0]qp,qn;
	
	always @ (qp,opr,l)
		begin
			case(opr)
			0 : qn <= {qp[N-2:0],l};
			1 : qn <= qp;
			2 : qn <= 0;
			3 : qn <= 0;
			endcase
			
			q <= qp;
			
		end
		
		
	always @ (posedge clk)
		begin
			if(rst==0)
				qp <= 0;
			else
				qp <= qn;
		end
endmodule