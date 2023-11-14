/*
Build class (my_comp) by extending uvm_component. Access the data shared by config_db from testbench top. 
Use run phase of the my_comp to send the value of accessed data from uvm_config db to the console. 
use the template mentioned in the instruction tab.
*/

`include "uvm_macros.svh"
import uvm_pkg::*;
 
 
/////////////////add your code here
class my_comp extends uvm_component;
  `uvm_component_utils(my_comp)
  
  string data;

  function new(input string path = "my_comp", uvm_component parent = null);
    super.new(path, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    assert(uvm_config_db#(string)::get(this,"","data",data));
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("MY_COMP", $sformatf("data : %0s",data), UVM_NONE);
    phase.drop_objection(this);
  endtask

endclass
 
///////////////////////////////
 
 
 
/////////////do not modify tb_top code
 
module tb;
 
string data = "UVM";
  
  
initial 
  
  begin
  uvm_config_db #(string)::set(null, "uvm_test_top", "data", data); 
  run_test("my_comp"); 
  end
 
endmodule

