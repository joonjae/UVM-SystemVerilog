/*
Create class extending uvm_object base class consisting of three data members (reg [3:0] a, reg [7:0] b, reg [15:0] c). 
Use the Random number facility of SV to generate a random number for b and c. 
Finally, print the value of all the data members on the Console.
*/
/*
`include "uvm_macros.svh"
 import uvm_pkg::*;
 
class temp extends uvm_object;
	   reg [3:0] a;
  rand reg [7:0] b;
  rand reg [15:0] c;
 
 
  function new(input string inst = "temp");
  super.new(inst);
  endfunction
 
`uvm_object_utils_begin(temp)
  `uvm_field_int(a,UVM_DEFAULT)
  `uvm_field_int(b,UVM_DEFAULT)
  `uvm_field_int(c,UVM_DEFAULT)
`uvm_object_utils_end
  
endclass
 
 
module tb;
  
  temp tr;
 
  initial begin
    tr = temp::type_id::create("tr");
    tr.randomize();
    tr.print();
  end
  
  
endmodule
*/

`include "uvm_macros.svh"

import uvm_pkg::*;

////////////////////////////////////////////

////all the classes -> create

////tlm ports -> new

class my_class extends uvm_object;

  rand reg [3:0] a;

  rand reg [7:0] b;

  rand reg [15:0] c;

  function new(input string inst = "object");

  super.new(inst);

  endfunction

  `uvm_object_utils_begin(my_class)

  `uvm_field_int(a,UVM_DEFAULT)

  `uvm_field_int(b,UVM_DEFAULT)

  `uvm_field_int(c,UVM_DEFAULT)

`uvm_object_utils_end

 

endclass

module tb;

 

  my_class M;

 

 

  initial begin

    M = my_class::type_id::create("M");

    M.randomize();

    M.print();

  end

 

 

endmodule