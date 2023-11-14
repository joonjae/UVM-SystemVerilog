`include "uvm_macros.svh"
`include "transaction_dff.svh"
`include "dff_if.svh"
import uvm_pkg::*;

class mon extends uvm_driver#(transaction_dff);
    `uvm_component_utils(mon)

    transaction_dff tr;
    virtual dff_if dif;

    function new(input string path = "mon", uvm_component parent = null);
        super.new(path, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr = transaction_dff::type_id::create("tr");
        if(!uvm_config_db#(transaction_dff)::get(this,"","dif",dif))
            uvm_error("MON", "Unhable to access interface");
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            repeat(2) @(posedge dif.clk);
            tr.rst = dif.rst ;
            tr.din = dif.din ;
            tr.dout= dif.dout ;
            `uvm_info("MON",$sformatf("rst:%0b, din:%0b, dout:%0b",tr.rst, tr.din, tr.dout), UVM_NONE);
            send.write(tr);
        end
    endtask
endclass