module contador_bt_v 
#(parameter n = 8,
  parameter c=199)
(
input rst,clk,
output reg bt
);

reg [n-1:0]qp, qn;

always @ (qp)
	begin
		if(qp==c)
			begin
			qn<=0;
			bt<=1;
			end
		else
			begin
			qn<=qp+1;
			bt<=0;
			end
	end	
	
always @ (posedge clk)
	begin
		if(rst==0)
			qp <= 0;
		else
			qp <= qn;	
	 end
endmodule