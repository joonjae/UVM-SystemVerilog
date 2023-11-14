<<<<<<< HEAD
module tb;
	reg [1:0] a = 0;
	reg rst = 0;
	integer i = 0;
	
	initial begin
		rst = 1;
		#30;
		rst = 0;
	end
	
	covergroup c;
		option.per_instance = 1;
		coverpoint a iff (!rst);
	endgroup
	
	initial begin
		c ci = new();
		for( i=0; i < 10 ; i++) begin
			a = $urandom();
			ci.sample();
			#10;
		end
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#100;
		$finish();
	end
 
=======
module tb;
	reg [1:0] a = 0;
	reg rst = 0;
	integer i = 0;
	
	initial begin
		rst = 1;
		#30;
		rst = 0;
	end
	
	covergroup c;
		option.per_instance = 1;
		coverpoint a iff (!rst);
	endgroup
	
	initial begin
		c ci = new();
		for( i=0; i < 10 ; i++) begin
			a = $urandom();
			ci.sample();
			#10;
		end
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#100;
		$finish();
	end
 
>>>>>>> origin/main
endmodule