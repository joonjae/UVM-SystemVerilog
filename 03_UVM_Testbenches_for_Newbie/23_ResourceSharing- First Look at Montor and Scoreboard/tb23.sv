// Copiado de la pagina

/////////////////////Interface



interface temp_if;
  
  logic [3:0] a;
 
endinterface


/////////////////////////////////Testbench Code

 
`include "uvm_macros.svh"
import uvm_pkg::*;
 
 
//////////////////////////////////////////////////////////////////////////
class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual temp_if tif;
  logic [3:0] a = 0;
  
  
  uvm_analysis_port#(logic [3:0]) m_analysis_write;
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_analysis_write = new("m_analysis_write",this);
    
    assert(uvm_config_db#(virtual temp_if)::get(this, "", "tif", tif));
  endfunction
  
  
  
  virtual task run_phase(uvm_phase phase);
    #10;
    $display("%0d", tif.a);
    a = tif.a;
    m_analysis_write.write(a);
  endtask
  
  
endclass
 
 
//////////////////////////////////////////////////////////////////////////
 
class scoreboard extends uvm_scoreboard;
 
  `uvm_component_utils(scoreboard)
  
  function new(string name = "SCO", uvm_component p = null);
    super.new(name,p);
  endfunction
  
  uvm_analysis_imp#(logic [3:0] , scoreboard) m_analysis_read;
  
  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     m_analysis_read = new("m_analysis_read",this);
  endfunction
  
  function void write(logic [3:0] t);
    `uvm_info("SCO",$sformatf("DATA Recv from MON : %0d",t), UVM_NONE);
  endfunction 
 
  
endclass
 
////////////////////////////////////////////////////////////
 
class env extends uvm_env;
  
  `uvm_component_utils(env)
  
  monitor m;
  scoreboard s;
  
  function new(string name = "ENV", uvm_component p = null);
    super.new(name,p);
  endfunction
  
   function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       m = monitor::type_id::create("MON",this);
       s = scoreboard::type_id::create("SCO",this);
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m.m_analysis_write.connect(s.m_analysis_read);
  endfunction
  
endclass
 
///////////////////////////////////////////////////
class test extends uvm_test;
  
  `uvm_component_utils(test)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  env e;
  
    function void build_phase(uvm_phase phase);
       super.build_phase(phase);
      e = env::type_id::create("ENV",this);
   endfunction
  
  
  
   task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #20;
    phase.drop_objection(this);
    endtask
  
  
endclass
  
 
//////////////////////////////////////////////////////
  module tb;
    
    temp_if tif();
    
    
    initial begin
      uvm_config_db#(virtual temp_if)::set(null, "*", "tif", tif);
    end
    
    initial begin
      tif.a <= 4'h2;
    end
     
    
    initial begin
      run_test("test");
    end
    
  endmodule
  
 
