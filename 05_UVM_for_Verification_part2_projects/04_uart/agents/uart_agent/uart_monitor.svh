
class uart_monitor extends uvm_monitor;
    `uvm_component(uart_monitor)

    uvm_analysis_port#(uart_seq_item) send;
    uart_seq_item tr;
    virtual uart_clk_if vif;
    real ton    = 0;
    real toff   = 0;

    function new(input string inst = "uart_monitor", uvm_component parent = null);
        super.new(inst, parent);
    endfunction //new()

    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      send = new("send", this);
      tr = transaction::type_id::create("tr");

      if(!uvm_config_db#(virtual uart_clk_if)::get(this,"","vif",vif))
        `uvm_error("uart_monitor","Unable to access interface");
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            if(vif.rst)begin
                tr.oper = reset_asserted;
                ton     = 0;
                toff    = 0;
                `uvm_info("UART_MONITOR", "SYSTEM RESET DETECTED", UVM_NONE);
                send.write(tr);
            end
            else begin
                tr.baud = vif.baud;
                tr.oper = random_baud;
                ton     = 0;
                toff    = 0;
                @(posedge vif.tx_clk);
                toff = $realtime;
                tr.period = toff - ton;
                `uvm_info("UART_MON",$sformatf("Baud : %0d Period:%0f",tr.baud, tr.period), UVM_NONE);
                send.write(tr);
            end
        end
    endtask
endclass //uart_monitor