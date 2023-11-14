`include "uvm_macros.svh"
import uvm_pkg::*;

class temp extends uvm_object;
	`uvm_object_utils(temp)

    bit [7:0] data_temp;

    function new(string inst = "temp");
        super.new(inst);
    endfunction

    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("data_temp", data_temp, $bits(data_temp), UVM_DEC);
    endfunction
endclass

class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)
    rand bit [7:0] data;
    temp t;

    function new(string inst = "transaction");
        super.new(inst);
        t = new("t");
    endfunction

    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("data", data, $bits(data), UVM_DEC);
        printer.print_object("t", t);
    endfunction

    virtual function void do_copy(uvm_object rhs);
        transaction tr;
        super.do_copy(rhs);
        $cast(tr, rhs);
        data = tr.data;
        t.data_temp = tr.t.data_temp;
    endfunction
endclass

module tb;
    transaction tr_a, tr_b;

    initial begin
        tr_a = new("tr_a");
        tr_b = new("tr_b");

        tr_a.randomize();
        tr_a.t.data_temp = 8'b0000_0011;
        tr_a.print();

        tr_b.copy(tr_a);
        tr_b.print();

        tr_b.t.data_temp = 8'b0000_0000;
        tr_a.print();
        tr_b.print();
    end
endmodule
