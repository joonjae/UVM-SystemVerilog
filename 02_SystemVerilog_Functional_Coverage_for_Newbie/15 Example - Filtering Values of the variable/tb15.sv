<<<<<<< HEAD
module tb;
	reg [2:0] a;
	integer i;
	
	covergroup c;
      option.per_instance = 1;
      coverpoint a{
        bins zero = {0};
		bins odd [] = a with ( (item % 2 != 0)&&(item > 0) ); 
		bins even [] = a with ( (item % 2 == 0)&&(item > 0) );
      }
	endgroup
	
	c ci;
	
	initial begin
		ci = new();
		for (i=0; i<20; i++) begin
          a = $urandom();
          $display("Value of a: %0d",a);
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
	integer i;
	
	covergroup c;
      option.per_instance = 1;
      coverpoint a{
        bins zero = {0};
		bins odd [] = a with ( (item % 2 != 0)&&(item > 0) ); 
		bins even [] = a with ( (item % 2 == 0)&&(item > 0) );
      }
	endgroup
	
	c ci;
	
	initial begin
		ci = new();
		for (i=0; i<20; i++) begin
          a = $urandom();
          $display("Value of a: %0d",a);
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