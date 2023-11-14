`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction_dff extends uvm_sequence_item;
    `uvm_object_utils(transaction_dff)

    rand bit din;
    rand bit rst;
    rand bit clk;
         bit dout;

    function new(input string path = "transaction_dff");
        super.new(path);
    endfunction
endclass