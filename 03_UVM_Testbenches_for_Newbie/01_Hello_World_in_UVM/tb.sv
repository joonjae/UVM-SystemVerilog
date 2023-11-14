
`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;

initial begin 
`uvm_info("TB_TOP", "Hello world", UVM_MEDIUM); // is, msg, verbosity
end

endmodule