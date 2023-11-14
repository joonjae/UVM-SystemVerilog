//Create four explicit bins for a,b and y and implicit bins for cout. Generate stimulus to cover all the generated bins (100 % Coverage).

module tb;
  
  reg [7:0] a, b;
  wire [7:0] sum;
  wire cout;
  
  integer i;
  
  top dut (a,b,sum,cout);
  
  covergroup C;
    option.per_instance = 1;
    coverpoint a{
      bins a[] = {0,2,11,127};
    }
    coverpoint b{
      bins b[] = {0,2,11,127};
    }
    coverpoint sum
    {
      bins sum [] = {0,4,22,255};
    }
    coverpoint cout;
  endgroup

  initial begin
    C ci = new();
    for(i=0; i<1000; i++)begin
      a = $urandom();
      b = $urandom();
      ci.sample;
	  #1;
    end
  end
  
  initial begin
	#1000;
	$finish();
  end
endmodule
