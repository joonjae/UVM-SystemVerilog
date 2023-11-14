<<<<<<< HEAD
module tb;   
	reg [1:0] a;
	reg [3:0] b;
	integer i = 0;
	
	covergroup c;
		option.per_instance = 1;
		option.goal = 62.5;
		type_option.goal = 90;
		
		coverpoint a{
//			option.weight = 1;
			option.goal = 100;
		}
		coverpoint b{
//			option.weight = 0;
			option.goal = 63;
		}
	endgroup

	initial begin
		c ci = new();
		for(i=0;i<20;i++)begin
			a = $urandom();
			b = $urandom();
			ci.sample();
			#10;
		end
	end
	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
=======
module tb;   
	reg [1:0] a;
	reg [3:0] b;
	integer i = 0;
	
	covergroup c;
		option.per_instance = 1;
		option.goal = 62.5;
		type_option.goal = 90;
		
		coverpoint a{
//			option.weight = 1;
			option.goal = 100;
		}
		coverpoint b{
//			option.weight = 0;
			option.goal = 63;
		}
	endgroup

	initial begin
		c ci = new();
		for(i=0;i<20;i++)begin
			a = $urandom();
			b = $urandom();
			ci.sample();
			#10;
		end
	end
	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
>>>>>>> origin/main
endmodule