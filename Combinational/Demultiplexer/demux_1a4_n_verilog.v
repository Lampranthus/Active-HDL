parameter N=4;

module demux_1a4_n_verilog(	 
	
	input [N-1:0]x, [1:0]s,
	output reg [N-1:0]y0,
	output reg [N-1:0]y1,
	output reg [N-1:0]y2,
	output reg [N-1:0]y3 
	
	);
	
	always @ (s,x)
		begin
			case(s)
				
			0	:	begin y0=x; y1=0; y2=0; y3=0; end
			1	:	begin y0=0; y1=x; y2=0; y3=0; end
			2	:	begin y0=0; y1=0; y2=x; y3=0; end
			3	:	begin y0=0; y1=0; y2=0; y3=x; end
			endcase
		end
	endmodule
				