<<<<<<< HEAD
module andt (
		input clk, rst, up, load,
		input [7:0] loadin,
		output reg [7:0] y
	);

	always@(posedge clk)
	begin
		if(rst == 1'b1)
			y <= 8'b00000000;
		else if (load == 1'b1)
			y <= loadin;
			else begin
				if(up == 1'b1)
					y <= y + 1;
				else
					y <= y - 1;
			end
	end
=======
module andt (
		input clk, rst, up, load,
		input [7:0] loadin,
		output reg [7:0] y
	);

	always@(posedge clk)
	begin
		if(rst == 1'b1)
			y <= 8'b00000000;
		else if (load == 1'b1)
			y <= loadin;
			else begin
				if(up == 1'b1)
					y <= y + 1;
				else
					y <= y - 1;
			end
	end
>>>>>>> origin/main
endmodule