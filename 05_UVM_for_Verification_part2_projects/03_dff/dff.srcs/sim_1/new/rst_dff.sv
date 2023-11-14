`include "uvm_macros.svh"
`include "transaction_dff.svh"
import uvm_pkg::*;

class rst_dff extends uvm_sequence#(transaction_dff);
    `uvm_object_utils(valid_din)

    transaction_dff tr;

    function new(input string path = "rst_dff");
        super.new(path);
    endfunction

    virtual task body();
        repeat(15) begin
            tr = transaction_dff::type_id::create("tr");
            start_item(tr);
                assert(tr.randomize());
                tr.rst = 1'b1;
                `uvm_info("SEQ",$sformatf("rst:%0b, din:%0b, dout:%0b",tr.rst, tr.din, tr.dout), UVM_NONE);
            finish_item(tr);
        end
    endtask

endclass