`include "uvm_macros.svh"
import uvm_pkg::*;

class comp extends uvm_component;
	`uvm_component_utils(comp)
	
	function new(string inst = "comp", uvm_component parent = null);
		super.new(inst, parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("COMP", "COMP BUILD PHASE EXECUTED", UVM_NONE);
	endfunction
	
endclass

class test extends uvm_test;
	`uvm_component_utils(test)
	
	comp c;
	
	function new(string inst = "test", uvm_component parent = null);
		super.new(inst, parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		c = comp::type_id::create("c", this);
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