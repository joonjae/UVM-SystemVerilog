class uart_agent extends uvm_agent;
    `uvm_component_utils(uart_agent)

    uart_driver     d;
    uvm_sequencer#(uart_seq_item) seqr;
    uart_mon        m;

    function new(input string inst = "uart_agent", uvm_component parent = null);
        super.new(inst, parent);        
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m = uart_mon::type_id::create("m", this);
        d = uart_mon::type_id::create("d",this);
        seqr = uvm_sequencer#(uart_seq_item)::type_id::create("seqr",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        d.seq_item_port.connect(seqr.seq_item_export);
    endfunction

endclass
