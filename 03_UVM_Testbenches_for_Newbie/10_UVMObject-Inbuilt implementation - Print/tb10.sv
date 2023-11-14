`include "uvm_macros.svh"
import uvm_pkg::*;

/////print , deep copy , compare clone pack/unpack record create : core methods
////inbuit implementation / do hooks
 
//field macros

class transaction extends uvm_sequence_item;
	rand bit [3:0] data;
	
	function new(string inst = "transaction");
		super.new(inst);
	endfunction
	
	`uvm_object_utils_begin(transaction)
		`uvm_field_int(data, UVM_DEFAULT | UVM_DEC)
	`uvm_object_utils_end
	
endclass

module tb;
	transaction t;
	initial begin
		t = new("t");
		t.randomize();
		t.print(uvm_default_tree_printer); ///tree table(default) line
		//t.print(uvm_default_line_printer); ///tree table(default) line
	end
endmodule