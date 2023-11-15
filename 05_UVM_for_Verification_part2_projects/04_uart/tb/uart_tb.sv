module tb;
    uart_clk_if vif();

    clock_gen dut (.clk(vif.clk),.rst(vif.rst),.baud(vif.baud),.tx_clk(vif.tx_clk));

    initial begin
        vif.clk <= 0;
    end

    always #10 vif.clk <= ~vif.clk;

    initial begin
        uvm_config_db#(virtual clk_if)::set(null, "*", "vif",vif);
        runt_test("uart_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule