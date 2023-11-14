module dff (
	input clk,rst,din,
	output reg dout  
);
  
	always_ff@(posedge clk)
	begin
		if(rst)
			dout <= 0;
		else
			dout <= din; 
	end

endmodule