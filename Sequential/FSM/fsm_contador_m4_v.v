module fsm_contador_m4_v(
	
	input rst, clk, opc,
	output reg [1:0]q
	
	); 
	
	reg [1:0]qp,qn;
	
	always @ (qp,opc)
		begin
			
			case(qp)
				
				0: 
				begin
					q <=0;
					if(opc==0)
						qn <= 1;
					else
						qn <= 3;
				end
				
				1: 
				begin
					q <=1;
					if(opc==0)
						qn <= 2;
					else
						qn <= 0;
				end
				
				2: 
				begin
					q <=2;
					if(opc==0)
						qn <= 3;
					else
						qn <= 1;
				end
				
				3: 
				begin
					q <=3;
					if(opc==0)
						qn <= 0;
					else
						qn <= 2;
				end
			endcase
		end
		
		always @ (posedge clk)
			begin  
				
				if(rst==0)
					qp <= 0;
				else
					qp <= qn;
			end
		
endmodule