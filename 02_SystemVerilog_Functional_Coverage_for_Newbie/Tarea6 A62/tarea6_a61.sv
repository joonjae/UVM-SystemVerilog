/*
Create a stimulus for D-Flipflop to cover following behavior of design. 
1) Cover all the possible values of rst 
2) Cover all the possible values of din 
3) Cover all the possible values of dout
Prefer posedge of clock as event
*/
module tb;
   
  reg din = 0;
  reg rst = 0;
  reg clk = 0;
  wire dout;
  integer i = 0;
  
  always #5 clk = ~clk;  
 
  dff dut(clk,rst,din,dout);
  
  covergroup c @(posedge clk);
    option.per_instance = 1;
    coverpoint din;
    coverpoint rst;
    coverpoint dout;  
  endgroup
  
  c ci;
  initial begin
    ci = new();
    for (i = 0; i <40; i++) begin
      @(posedge clk);
      din = $urandom();
      rst = $urandom();
    end
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #400;
    $finish();
  end

endmodule