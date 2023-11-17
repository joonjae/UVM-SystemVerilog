//  Package: uart_agent_pkg
//
package uart_agent_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //  Group: Typedefs
    typedef enum bit [1:0] {reset_asserted = 0, random_baud = 1} oper_mode;

    //  Group: Parameters
    `include "uart_agent.svh"
    `include "uart_baud_seq.svh"
    `include "uart_driver.svh"
    `include "uart_env.svh"
    `include "uart_monitor.svh"
    `include "uart_reset_seq.svh"
    `include "uart_sco.svh"
    `include "uart_seq_item.svh"

endpackage: uart_agent_pkg