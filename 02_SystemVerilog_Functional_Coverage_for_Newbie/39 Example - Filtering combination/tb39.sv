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

		cross rst,wr, addr;
	endgroup

	covergroup c2;
		option.per_instance = 1;
		coverpoint rst {
			bins rst_high = {1};
		}
	endgroup


	c ci;
	c2 ci2;
	initial begin
		ci = new();
		ci2 = new();
		for (i = 0; i <50; i++) begin
			addr = $urandom();
			wr = $urandom();
			rst = $urandom();
			ci.sample();
			ci2.sample();
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

		cross rst,wr, addr;
	endgroup

	covergroup c2;
		option.per_instance = 1;
		coverpoint rst {
			bins rst_high = {1};
		}
	endgroup


	c ci;
	c2 ci2;
	initial begin
		ci = new();
		ci2 = new();
		for (i = 0; i <50; i++) begin
			addr = $urandom();
			wr = $urandom();
			rst = $urandom();
			ci.sample();
			ci2.sample();
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