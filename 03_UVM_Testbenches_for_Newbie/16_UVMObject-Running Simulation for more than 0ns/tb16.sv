`include "uvm_macros.svh"
import uvm_pkg::*;

class test extends uvm_test;
	`uvm_component_utils(test);
	
	function new(input string inst = "test", uvm_component parent = null);
		super.new(inst, parent);
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		#10;
		`uvm_info("TEST", "Executed Test Run Phase", UVM_NONE);
		phase.drop_objection(this);
	endtask
endclass

module tb;

	initial begin
		run_test("test");
	end
	
endmodule