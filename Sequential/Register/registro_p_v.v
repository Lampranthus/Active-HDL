module registro_p_v
	#(parameter N = 4)
	
	(
	input rst,clk,
	input [1:0]opr,
	input [N-1:0]din,
	output reg [N-1:0]dout
	);
	
	reg [N-1:0]qp,qn;
	
	always @ (qp,opr,din)
		begin
			case(opr)
			0 : qn <= din;
			1 : qn <= qp;
			2 : qn <= 0;
			3 : qn <= 0;
			endcase
			
			dout <= qp;
			
		end
		
		
	always @ (posedge clk)
		begin
			if(rst==0)
				qp <= 0;
			else
				qp <= qn;
		end
endmodule