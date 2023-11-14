`include "uvm_macros.svh"
import uvm_pkg::*;

class comp extends uvm_component;
	`uvm_component_utils(comp);
	
	function new(string inst = "comp", uvm_component parent = null);
		super.new(inst, parent);
	endfunction
endclass

module tb;
	comp c;
	
	initial begin
		c = new("c",null);
	end
endmodule