module SHR_v
	#(parameter N = 4)
	
	(
	input rst,clk,r,
	input [1:0]opr,
	output reg [N-1:0]q
	);
	
	reg [N-1:0]qp,qn;
	
	always @ (qp,opr,r)
		begin
			case(opr)
			0 : qn <= {r,qp[N-1:1]};
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