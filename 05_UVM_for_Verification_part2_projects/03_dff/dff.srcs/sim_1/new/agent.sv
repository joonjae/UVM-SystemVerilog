`include "uvm_macros.svh"
`include "transaction_dff.svh"
`include "dff_if.svh"
import uvm_pkg::*;

class agent extends uvm_agent;
    `uvm_component_utils(agent)

    drv d;
    mon m;
    config_dff cfg;
    uvm_sequence#(transaction) seqr;

    function new(input string path = "agent", uvm_component parent = null);
        super.new(path, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m = mon::type_id::create("mon",this);
        cfg = config_dff::type_id::create("cfg",this);
        if(!uvm_config_db#(config_dff)::get(this,"","cfg",cfg))
            `uvm_error("AGENT", "FAILED TO ACCESS CONFIG");
        if( cfg.agent_type == UVM_ACTIVE )begin
            d = drv::type_id::create("d",this);
            seqr = uvm_sequence#(transaction_dff)::type_id::create("seqr",this);
        end
    endfunction

    virtual function void connect_phase(uvm_phase pahse);
        super.connect_phase(phase);
        d.seq_item_port.connect( seqr.seq_item_export );
    endfunction
endclass