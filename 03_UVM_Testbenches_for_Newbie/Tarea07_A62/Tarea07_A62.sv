/*
Build UVM_TREE consisiting of 3 components (comp_a, comp_b and comp_c). 
comp_a is the child of the UVM_ROOT while comp_b and comp_c are childs of comp_a. 
Add the reporting macros in the build_phase of each component to indicate 
"Build Phase of COMP_X executed". UVM_TREE is shown in Instructions tab.
*/


`include "uvm_macros.svh"
import uvm_pkg::*;
 
 
class comp_a extends uvm_component;
  `uvm_component_utils(comp_a)
  
  function new(string inst = "comp_a", uvm_component parent = null);
    super.new(inst, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("COMP_A", "Build Phase of COMP_A executed", UVM_NONE);
  endfunction
  
endclass
 

class comp_b extends uvm_component;
  `uvm_component_utils(comp_b)
  
  function new(string inst = "comp_b", uvm_component parent = null);
    super.new(inst, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("COMP_B", "Build Phase of COMP_B executed", UVM_NONE);
  endfunction
  
endclass

class comp_c extends uvm_component;
  `uvm_component_utils(comp_c)
  
  function new(string inst = "comp_c", uvm_component parent = null);
    super.new(inst, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("COMP_C", "Build Phase of COMP_C executed", UVM_NONE);
  endfunction
  
endclass


class test extends uvm_test;
  `uvm_component_utils(test)
  
  comp_a a;
  comp_b b;
  comp_c c;
  
  function new(string inst = "test", uvm_component parent = null);
    super.new(inst, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a = comp_a::type_id::create("a", this);
	b = comp_b::type_id::create("b", a	 );
	c = comp_c::type_id::create("c", a	 );
    `uvm_info("TEST", "TEST BUILD PHASE EXECUTED", UVM_NONE);
  endfunction
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
endclass
 
 
module tb;
	initial begin
		run_test("test");
	end
  
endmodule

/*



`include "uvm_macros.svh"

import uvm_pkg::*;

class comp_a extends uvm_component;

  `uvm_component_utils(comp_a)

 

 

  function new(string inst="comp_a" , uvm_component parent=null);

    super.new(inst,parent);

  endfunction

 

 

  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);

   

   

    `uvm_info("COMP_a", "COMP_a BUILD PHASE EXECUTED", UVM_NONE);

  endfunction

endclass

class comp_b extends uvm_component;

  `uvm_component_utils(comp_b)

 

  function new(string inst="comp_b" , uvm_component parent=null);

    super.new(inst,parent);

  endfunction

 

  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    `uvm_info("COMP_b", "COMP_b BUILD PHASE EXECUTED", UVM_NONE);

  endfunction

endclass

class comp_c extends uvm_component;
  `uvm_component_utils(comp_c)
  function new(string inst="comp_c" , uvm_component parent=null);
    super.new(inst,parent);
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("COMP_c", "COMP_c BUILD PHASE EXECUTED", UVM_NONE);
  endfunction
endclass



class test extends uvm_test;
  `uvm_component_utils(test)

  comp_a c;
  comp_b c1;
  comp_c c2;

  function new(string inst = "test", uvm_component parent=null);
    super.new(inst, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    c = comp_a::type_id::create("c", this);
    c1=comp_b::type_id::create("c1",c);
    c2=comp_c::type_id::create("c2",c);
    `uvm_info("TEST", "TEST BUILD PHASE EXECUTED", UVM_NONE);
  endfunction
endclass


module tb;
  initial begin
    run_test("test");
  end
endmodule



/*

`include "uvm_macros.svh"

import uvm_pkg::*;



class comp_b extends uvm_component;



`uvm_component_utils(comp_b);

function new(string inst = "comp_b", uvm_component parent = null);

super.new(inst,parent);

endfunction



virtual function void build_phase(uvm_phase phase);

super.build_phase(phase);

`uvm_info("comp_b","Build Phase of COMP_B executed",UVM_NONE);

endfunction



endclass



class comp_c extends uvm_component;

`uvm_component_utils(comp_c);



function new(string inst = "comp_c", uvm_component parent=null);

super.new(inst,parent);

endfunction



virtual function void build_phase(uvm_phase phase);

super.build_phase(phase);

`uvm_info("comp_c","Build Phase of COMP_C executed",UVM_NONE);

endfunction



endclass



class comp_a extends uvm_test;

`uvm_component_utils(comp_a);

comp_b b;

comp_c c;



function new(string inst = "comp_a", uvm_component parent = null);

super.new(inst,parent);

endfunction



virtual function void build_phase(uvm_phase phase);

phase.build_phase(phase);

b=comp_b::type_id::create("b",this);

c=comp_c::type_id::create("c",this);

`uvm_info("comp_a","Build Phase of COMP_A executed",UVM_NONE);

endfunction





virtual function void end_of_elaboration_phase(uvm_phase phase);

super.end_of_elaboration_phase(phase);

uvm_top.print_topology();

endfunction



endclass







module tb;



initial begin

run_phase(comp_a);

end

endmodule
*/