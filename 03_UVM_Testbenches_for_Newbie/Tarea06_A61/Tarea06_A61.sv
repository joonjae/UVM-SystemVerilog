/*
Create class(my_comp) by extending uvm_component class. 
use the run_phase of the comp class to send the message 
"Triggering Interface @ 50" at 50 nsec.
*/
/*
`include "uvm_macros.svh"
import uvm_pkg::*;

class my_comp extends uvm_component;
	`uvm_component_utils(my_comp)
	
	function new(string inst = "my_comp", uvm_component parent = null);
		super.new(inst, parent);
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		#50;
		`uvm_info("MY_COMP", "Triggering Interface @ 50", UVM_NONE);
		phase.drop_objection(this);
	endtask
endclass

module tb;
	initial begin
		run_test("my_comp");
	end
endmodule
*/

`include "uvm_macros.svh"

import uvm_pkg::*;

class my_comp extends uvm_component;
	`uvm_component_utils(my_comp);
	
	function new(string path = "my_comp", uvm_component parent = null);
		super.new(path,parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	#50;
	`uvm_info("MY_COMP","Triggering Interface @50",UVM_NONE);
	phase.drop_objection(this);
    endtask
endclass

module tb;

initial begin
run_phase("my_comp");
end

endmodule