class uart_sco extends uvm_scoreboard;
    `uvm_component_utils(uart_sco)

    real count = 0;
    real baudcount =0;

    uvm_analysis_imp#(uart_seq_item, uart_sco) recv;

    function new(input string inst = "uart_sco", uvm_component parent = null);
        super.new(inst, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        recv = new("uart_sco_recv", this);        
    endfunction

    virtual function void write(uart_seq_item tr);
        count = tr.period;
        baudcount = count;
        `uvm_info("UART_SCO", $sformatf("BAUD: %0d count:%0f bcount:%0f", tr.period, count, baudcount));
        case(tr.baud)
            4800: begin
                if(baudcount == 10418)
                    `uvm_info("UART_SCO", "TEST PASSED", UVM_NONE)
                else
                    `uvm_info("UART_SCO", "TEST FAILED")
            end
            9600: begin
                if(baudcount == 5210)
                    `uvm_info("UART_SCO", "TEST PASSED", UVM_NONE)
                else
                    `uvm_info("UART_SCO", "TEST FAILED")
            end
            14400: begin
                if(baudcount == 3474)
                    `uvm_info("UART_SCO", "TEST PASSED", UVM_NONE)
                else
                    `uvm_info("UART_SCO", "TEST FAILED")
            end
            19200: begin
                if(baudcount == 2606)
                    `uvm_info("UART_SCO", "TEST PASSED", UVM_NONE)
                else
                    `uvm_info("UART_SCO", "TEST FAILED")
            end
            38400: begin
                if(baudcount == 1304)
                    `uvm_info("UART_SCO", "TEST PASSED", UVM_NONE)
                else
                    `uvm_info("UART_SCO", "TEST FAILED")
            end
            57600: begin
                if(baudcount == 870)
                    `uvm_info("UART_SCO", "TEST PASSED", UVM_NONE)
                else
                    `uvm_info("UART_SCO", "TEST FAILED")
            end
        endcase
    endfunction
endclass