`include "uvm_macros.svh"
import uvm_pkg::*;
////////////////////////////////////////////
////all the classes -> create
////tlm ports -> new

class transaction extends uvm_sequence_item;
    rand bit [3:0] a;
    rand bit [3:0] b;
         bit [4:0] y;

    function new(input string inst = "transaction");
        super.new(inst);
    endfunction

    `uvm_object_utils_begin(transaction)
        `uvm_field_int(a,UVM_DEFAULT)
        `uvm_field_int(b,UVM_DEFAULT)
        `uvm_field_int(y,UVM_DEFAULT)
    `uvm_object_utils_end
endclass

module tb;
    transaction tr;

    initial begin
        tr = transaction::type_id::create("tr");
        tr.randomize();
        tr.print();
    end    
endmodule