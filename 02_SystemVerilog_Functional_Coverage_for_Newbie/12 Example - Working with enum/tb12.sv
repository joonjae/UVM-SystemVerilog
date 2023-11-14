<<<<<<< HEAD
module tb;
	typedef enum bit [1:0] {s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11} fsmstate;
	fsmstate var1;
	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
	
	covergroup c;
		option.per_instance = 1;
		coverpoint var1;
	endgroup
	
	initial begin
		c cia=new();
		//var1 = s0;
		$cast(var1,2'b00);
		cia.sample();
	end
	
	
=======
module tb;
	typedef enum bit [1:0] {s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11} fsmstate;
	fsmstate var1;
	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
	
	covergroup c;
		option.per_instance = 1;
		coverpoint var1;
	endgroup
	
	initial begin
		c cia=new();
		//var1 = s0;
		$cast(var1,2'b00);
		cia.sample();
	end
	
	
>>>>>>> origin/main
endmodule