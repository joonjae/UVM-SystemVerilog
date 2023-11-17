class uart_test extends uvm_test;
    `uvm_component_utils(uart_test);

    uart_env e;
    uart_baud_seq vbar;
    reset_clk rclk;

    function new(input string inst = "uart_test", uvm_component c);
        super.new(inst, c);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        e = uart_env::type_id::create("uart_env",this);
        vbar = uart_baud_seq::type_id::create("vbar");
        rclk = reset_clk::type_id::create("rclk");
    endfunction

    virtual task run_phase (uvm_phase phase);
        phase.raise_objection(this);
        vbar.start(e.a.seqr);
        #20;
        phase.drop_objection(this);
    endtask
endclass