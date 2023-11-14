<<<<<<< HEAD
module tb;  
	reg [3:0] dout=0;
	reg en = 0;
	integer i = 0;

	covergroup c;
		option.per_instance = 1;
		coverpoint {en,dout} {
		wildcard bins normal_op = {5'b1????};
		bins off = {5'b00000};
		wildcard bins error = {5'b0????} with (item != 0);
	}
	endgroup

	c ci;
	initial begin
		ci = new(); 
		en = 1;
		#200;
		en = 0;
	end

	initial begin
		for(i = 0; i < 20; i++) begin
			dout = dout + 1;
			ci.sample();
			#10;
		end

		for(i = 0; i < 15; i++) begin
			dout = 0;
			ci.sample();
			#10;
		end
		for(i = 0; i < 5; i++) begin
			dout = dout + 1;
			ci.sample();
			#10;
		end

	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#400;
		$finish();
	end
  
=======
module tb;  
	reg [3:0] dout=0;
	reg en = 0;
	integer i = 0;

	covergroup c;
		option.per_instance = 1;
		coverpoint {en,dout} {
		wildcard bins normal_op = {5'b1????};
		bins off = {5'b00000};
		wildcard bins error = {5'b0????} with (item != 0);
	}
	endgroup

	c ci;
	initial begin
		ci = new(); 
		en = 1;
		#200;
		en = 0;
	end

	initial begin
		for(i = 0; i < 20; i++) begin
			dout = dout + 1;
			ci.sample();
			#10;
		end

		for(i = 0; i < 15; i++) begin
			dout = 0;
			ci.sample();
			#10;
		end
		for(i = 0; i < 5; i++) begin
			dout = dout + 1;
			ci.sample();
			#10;
		end

	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#400;
		$finish();
	end
  
>>>>>>> origin/main
endmodule