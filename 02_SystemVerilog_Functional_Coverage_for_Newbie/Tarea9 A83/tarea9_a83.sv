/* Prefer cross and ignore bins
Generate stimulus to get 100% coverage for the following Scenarios
1) Cover all the possible combinations of a,b,c
2) Cover cross between a and even values of b
3) Cover cross between a and odd values of c
4) Cover cross between even values of b and odd  values of c
*/
module tb;
   
	reg [1:0] a=0,b=0,c=0;
	wire [3:0] y;
	integer i = 0;

	top dut(a,b,c,y);
  
  covergroup cv;
	option.per_instance = 1;
	coverpoint a;
	coverpoint b;
	coverpoint c;

	cross_a_b: cross a,b {
      ignore_bins b = binsof(b) intersect {1,3};
	}

	cross_a_c: cross a,c {
      ignore_bins c = binsof(c) intersect {0,2};
	}

	cross_b_c: cross b,c {
		ignore_bins b 	= binsof(b)  intersect {1,3};
		ignore_bins c 	= binsof(c)  intersect {0,2};
	}
  endgroup
  
  cv ci;
  initial begin
    ci = new();
    for (i = 0; i <100; i++) begin
      a = $urandom();
      b = $urandom();
	  c = $urandom();
	  ci.sample();
	  #10;
    end
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #1000;
    $finish();
  end

endmodule