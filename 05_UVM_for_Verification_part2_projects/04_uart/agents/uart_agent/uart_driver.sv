
class uart_driver extends uvm_driver#(uart_seq_item);
    `uvm_component_utils(uart_driver)

    virtual uart_clk_if vif;
    uart_seq_item tr;

    function new(input string path = "uart_drv", uvm_component parent = null);
        super.new(path, parent);        
    endfunction //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr = uart_seq_item::type_id::create("tr");
        if(!uvm_config_db#(virtual uart_clk_if)::get(this, "", "vif", vif))
            `uvm_error("uart_drv", "Unable to access interface");
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(tr);
            if(tr.oper == reset_asserted)begin
                vif.rst <= 1'b1;
                @(posedge vif.clk)
            end
            else if(tr.ope == random_baud) begin
                `uvm_info("UART_DRV", $sformatf("Baud: %0d",tr.baud), UVM_NONE);
                vif.rst <= 1'b0;
                vif.baud <= tr.baud;
                @(posedge vif.clk);
                @(posedge vif.tx_clk);
                @(posedge vif.tx_clk);
            end
            seq_item_port.item_done();
        end
    endtask
endclass //uart_driver 