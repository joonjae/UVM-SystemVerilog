<<<<<<< HEAD
module tb;
  reg [1:0] a; /// 00 01 10 11 -> 0 1 2 3
  reg b;
  
  reg clk = 0;
  integer i = 0;
  
  always #5 clk = ~clk;
  
  initial begin
    #100;
    $finish();    
  end
  
 ///// synchronizing Signal -> event
/*
  
  covergroup c @(posedge clk);
    coverpoint a;
  endgroup
*/
  
  
   //// Manual specify when to sample the value -> event 
  
  covergroup c;
    option.per_instance = 1;
    coverpoint a;
    coverpoint b;
  endgroup
  
  
  
  
  initial begin
    c ci = new();
    for(i = 0; i < 10; i++) begin 
      @(posedge clk);
      a = $urandom();
      b = $urandom();
      $info("Value of a : %0d and b : %0b", a, b);
      ci.sample();
    end 
  end
 
=======
module tb;
  reg [1:0] a; /// 00 01 10 11 -> 0 1 2 3
  reg b;
  
  reg clk = 0;
  integer i = 0;
  
  always #5 clk = ~clk;
  
  initial begin
    #100;
    $finish();    
  end
  
 ///// synchronizing Signal -> event
/*
  
  covergroup c @(posedge clk);
    coverpoint a;
  endgroup
*/
  
  
   //// Manual specify when to sample the value -> event 
  
  covergroup c;
    option.per_instance = 1;
    coverpoint a;
    coverpoint b;
  endgroup
  
  
  
  
  initial begin
    c ci = new();
    for(i = 0; i < 10; i++) begin 
      @(posedge clk);
      a = $urandom();
      b = $urandom();
      $info("Value of a : %0d and b : %0b", a, b);
      ci.sample();
    end 
  end
 
>>>>>>> origin/main
endmodule