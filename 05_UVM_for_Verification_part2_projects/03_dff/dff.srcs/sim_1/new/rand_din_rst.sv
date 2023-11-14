`include "uvm_macros.svh"
`include "transaction_dff.svh"
import uvm_pkg::*;

class valid_din_rst extends uvm_sequence#(transaction_dff);
    `uvm_object_utils(valid_din_rst)

    transaction_dff tr;

    function new(input string path = "valid_din_rst");
        super.new(path);
    endfunction

    virtual task body();
        repeat(15) begin
            tr = transaction_dff::type_id::create("tr");
            start_item(tr);
                assert(tr.randomize());
                `uvm_info("SEQ",$sformatf("rst:%0b, din:%0b, dout:%0b",tr.rst, tr.din, tr.dout), UVM_NONE);
            finish_item(tr);
        end
    endtask

endclass