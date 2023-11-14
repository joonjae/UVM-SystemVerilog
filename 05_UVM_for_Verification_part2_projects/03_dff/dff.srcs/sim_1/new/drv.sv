`include "uvm_macros.svh"
`include "transaction_dff.svh"
`include "dff_if.svh"
import uvm_pkg::*;

class drv extends uvm_driver#(transaction_dff);
    `uvm_component_utils(drv)

    transaction_dff tr;
    virtual dff_if dif;

    function new(input string path = "drv", uvm_component parent = null);
        super.new(path, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(transaction_dff)::get(this,"","dif",dif))
            uvm_error("DRV", "Unhable to access interface");
    endfunction

    virtual task run_phase(uvm_phase phase);
        tr = transaction_dff::type_id::create("tr");
        forever begin
            seq_item_port.get_next_item(tr);
            dif.rst = tr.rst;
            dif.din = tr.din;
            `uvm_info("DRV",$sformatf("rst:%0b, din:%0b, dout:%0b",tr.rst, tr.din, tr.dout), UVM_NONE);
            seq_item_port.item_done();
            repeat(2) @(posedge dif.clk);
        end
    endtask
endclass