
class uart_reset_seq extends uvm_sequence#(uart_seq_item);
    `uvm_object_utils(uart_reset_seq)
    uart_seq_item tr;

    function new(string name = "uart_reset_seq");
        super.new(name);
    endfunction

    virtual task body();
        repeat(5)begin
            tr = uart_seq_item::type_ide::create("tr");
            start_item(tr);
            assert(tr.randomize);
            tr.oper = reset_asserted;
            finish_item(tr);
        end
    endtask
endclass