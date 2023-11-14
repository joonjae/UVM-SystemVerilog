<<<<<<< HEAD
module tb;
	reg wr;
	reg rst;
	reg [3:0] addr;

	integer i = 0;

	covergroup c ;
		option.per_instance = 1;
		coverpoint rst {
			bins rst_low = {0};
			bins rst_high = {1};
		}

		coverpoint wr {
			bins wr_low = {0};
			bins wr_high = {1};
		}

		coverpoint addr     
		{
			bins lower_addr = {[0:3]};
			bins mid_addr = {[4:11]};
			bins high_addr = {[12:15]};
		}

		cross rst,wr, addr{
			bins cross_rst_low = binsof(rst) intersect{0};
		}
	endgroup


	c ci;
	initial begin
		ci = new();
		for (i = 0; i <50; i++) begin
			addr = $urandom();
			wr = $urandom();
			rst = $urandom();
			ci.sample();
			#10;
		end  
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#500;
		$finish();
	end  
=======
module tb;
	reg wr;
	reg rst;
	reg [3:0] addr;

	integer i = 0;

	covergroup c ;
		option.per_instance = 1;
		coverpoint rst {
			bins rst_low = {0};
			bins rst_high = {1};
		}

		coverpoint wr {
			bins wr_low = {0};
			bins wr_high = {1};
		}

		coverpoint addr     
		{
			bins lower_addr = {[0:3]};
			bins mid_addr = {[4:11]};
			bins high_addr = {[12:15]};
		}

		cross rst,wr, addr{
			bins cross_rst_low = binsof(rst) intersect{0};
		}
	endgroup


	c ci;
	initial begin
		ci = new();
		for (i = 0; i <50; i++) begin
			addr = $urandom();
			wr = $urandom();
			rst = $urandom();
			ci.sample();
			#10;
		end  
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#500;
		$finish();
	end  
>>>>>>> origin/main
endmodule