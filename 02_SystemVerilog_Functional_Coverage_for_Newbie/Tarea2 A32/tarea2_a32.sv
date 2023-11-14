//Create implicit bins for din, rst, state variable(State), and dout.
//Generate stimulus to cover all the generated bins (100 % Coverage).

module tb;
  reg din=0;
  reg rst=0;
  reg clk=0;
  wire dout;
  
  integer i;
  
  fsm dut(rst, din, clk, dout);
  
  always #5 clk = ~clk;
  
  covergroup C;
	option.per_instance = 1;
    coverpoint din;
    coverpoint rst;
    coverpoint dut.state;
    coverpoint dout;    
  endgroup
  
  initial begin
    rst = 1;
    #30;
    rst = 0;
    #40;
	for (i=0; i<10 ; i++)begin
		@(posedge clk);
		din = $urandom();
	end
  end
  
  C ci;
  initial begin
	ci = new();
	forever begin
		@(posedge clk);
		ci.sample();
	end
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #300;
    $finish();
  end
  
endmodule

