module tb;

	reg [3:0] a;
	integer i = 0;
	
	covergroup c;
		option.per_instance = 1;
		coverpoint a;
	endgroup
	
	c ci;
	
	initial begin
		ci = new();
		
		for (i = 0; i<50; i++) begin
			a = $urandom();
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
	

endmodule
