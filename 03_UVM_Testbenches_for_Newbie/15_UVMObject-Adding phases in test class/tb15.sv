`include "uvm_macros.svh"
import uvm_pkg::*;

class test extends uvm_test;
	`uvm_component_utils(test)
	
	function new(string path = "test", uvm_component parent = null);
		super.new(path, parent);
	endfunction
	
	// contruction phases
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("test","Build phase executed", UVM_NONE);
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("test","Connect phase executed", UVM_NONE);
	endfunction
	
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		`uvm_info("test","Start of simulation phase executed", UVM_NONE);
	endfunction
	
	
	virtual task run_phase(uvm_phase phase);
		`uvm_info("test", "Run phase executed", UVM_NONE);
	endtask
	
	// Cleanup phases
	virtual function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
		`uvm_info("test", "Extract phase", UVM_NONE);
	endfunction
	
	virtual function void check_phase(uvm_phase phase);
		super.extract_phase(phase);
		`uvm_info("test", "Check phase", UVM_NONE);
	endfunction
	
	virtual function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info("test", "report phase", UVM_NONE);
	endfunction
	
	virtual function void final_phase(uvm_phase phase);
		super.final_phase(phase);
		`uvm_info("test", "Final Phase", UVM_NONE); 
	endfunction
endclass

module tb;
	initial begin
		run_test("test");
	end
endmodule