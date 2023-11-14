/* Prefer cross and ignore bins
Generate stimulus to get 100% coverage for the following Scenarios
1) Cover all the possible combinations of a,b
2) Cover rst.
3) Cover cross between rst (low) and a.
4) Cover cross between rst (low) and b.
5) Cover cross between a (00,11) and b(00,11) when rst is low.
*/
module tb;
   
	reg [2:0] a=0,b=0;
	reg rst,feed;
	wire [2:0] y;
	wire done;
	integer i = 0;

	top dut(a,b,rst,feed,y,done);
  
  covergroup cv;
	option.per_instance = 1;
	coverpoint a;
	coverpoint b;
	coverpoint rst;

	cross_rst_a: cross rst,a {
		ignore_bins rst = binsof(rst) intersect {1};
	}

	cross_rst_b: cross rst,b {
		ignore_bins rst = binsof(rst) intersect{1};
	}

	cross_a_b_rst: cross a,b,rst {
		ignore_bins a 	= binsof(a) 	intersect{1,2,[4:$]};
		ignore_bins b 	= binsof(b) 	intersect{1,2,[4:$]};
		ignore_bins rst = binsof(rst) 	intersect{1};
	}
  endgroup
  
  cv ci;
  initial begin
    ci = new();
    for (i = 0; i <1000; i++) begin
      a = $urandom();
      b = $urandom();
	  rst = $urandom();
	  ci.sample();
	  #10;
    end
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #10000;
    $finish();
  end

endmodule