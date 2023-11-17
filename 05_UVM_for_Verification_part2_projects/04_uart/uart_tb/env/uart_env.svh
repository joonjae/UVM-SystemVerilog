class uart_env extends uvm_env;
    `uvm_component_utils(uart_env)

    uart_agent  a;
    uart_sco    s;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        a = uart_agent::type_id::create("a",this);
        s = uart_sco::type_id::create("s",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        a.m.send.connect(s.recv);
    endfunction

endclass