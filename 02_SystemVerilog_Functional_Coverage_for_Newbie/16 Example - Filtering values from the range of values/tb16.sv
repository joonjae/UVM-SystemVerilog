<<<<<<< HEAD
module tb;
	reg [2:0] a;
    reg [5:0] btemp;
	integer i;
	int b; // 1:100 divisible by 5
	
	covergroup c;
      option.per_instance = 1;
      coverpoint b{
		bins zero = {0};
		bins bdiv5 [] = {[1:100]} with (item % 5 == 0);
	  }
	endgroup
	
	c ci;
	
	initial begin
		ci = new();
		for (i=0; i<20; i++) begin
          btemp = $urandom();
          b = btemp;
          $display("Value of b: %0d",b);
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
	reg [2:0] a;
    reg [5:0] btemp;
	integer i;
	int b; // 1:100 divisible by 5
	
	covergroup c;
      option.per_instance = 1;
      coverpoint b{
		bins zero = {0};
		bins bdiv5 [] = {[1:100]} with (item % 5 == 0);
	  }
	endgroup
	
	c ci;
	
	initial begin
		ci = new();
		for (i=0; i<20; i++) begin
          btemp = $urandom();
          b = btemp;
          $display("Value of b: %0d",b);
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