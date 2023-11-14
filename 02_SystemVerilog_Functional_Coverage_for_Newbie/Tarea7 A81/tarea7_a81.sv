/*
Generate stimulus to get 100% coverage for the following Scenarios
1) Cover all the possible combinations of a,b and c
2) Cover cross of a( 00, 01 ) with all the values of b.
3) Cover cross of b(11) with all the possible values of c.
4) Cover cross of a (10), b(10), and c(10)
*/
module tb;
   
  reg [1:0] a=0,b=0,c = 0;
  wire [3:0] y;
  integer i = 0;
  
  top dut(a,b,c,y);
  
  covergroup cv;
    option.per_instance = 1;
    coverpoint a;
    coverpoint b;
    coverpoint c;
	
	cross_a_b: cross a,b {
		ignore_bins a=binsof(a) intersect {2,3};
	}

	cross_b_c: cross b,c {
		ignore_bins b=binsof(b) intersect{[0:2]};
	}

	cross_a_b_c: cross a,b,c {
		ignore_bins a=binsof(a) intersect{0,1,3};
		ignore_bins b=binsof(b) intersect{0,1,3};
		ignore_bins c=binsof(c) intersect{0,1,3};
	}
  endgroup
  
  cv ci;
  initial begin
    ci = new();
    for (i = 0; i <40; i++) begin
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
    #400;
    $finish();
  end

endmodule