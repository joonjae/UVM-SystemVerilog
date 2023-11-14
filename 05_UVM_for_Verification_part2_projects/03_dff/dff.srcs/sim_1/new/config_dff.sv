`include "uvm_macros.svh"
import uvm_pkg::*;

class config_dff extends uvm_object;
    `uvm_object_utils(config_dff)

    uvm_active_pasive_enum agent_type = UVM_ACTIVE;

    function new( input string path = "config_dff");
        super.new(path);
    endfunction
endclass

