module mux_2 (
	input [1:0] a,b,
	input sel,
	output reg [1:0] y 
);

always_comb
	begin
	if(sel) 
	  y = a;
	else
	  y = b;
end

endmodule