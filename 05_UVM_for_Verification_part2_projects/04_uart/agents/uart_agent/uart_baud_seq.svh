class uart_baud_seq extends uvm_sequence#(uart_seq_item);
    `uvm_object_utils(uart_baud_seq)

    uart_baud_seq tr;

    function new(string name = "uart_baud_seq");
        super.new(name);
    endfunction

    virtual task body();
        repeat(5)begin
            tr = uart_seq_item::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.oper = random_baud;
            finish_item(tr);
        end
    endtask

endclass: uart_baud_seq