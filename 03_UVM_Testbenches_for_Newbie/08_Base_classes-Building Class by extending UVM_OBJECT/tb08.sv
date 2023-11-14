`include "uvm_macros.svh"
import uvm_pkg::*;

class obj extends uvm_object;
	`uvm_object_utils(obj);
	
	function new(string inst = "obj");
		super.new(inst);
	endfunction
endclass

module tb;
	obj o;
	initial begin
		o = new("o");
	end
endmodule