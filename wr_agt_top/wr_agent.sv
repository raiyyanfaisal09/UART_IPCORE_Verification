class wr_agent extends uvm_agent;
`uvm_component_utils(wr_agent)

 wr_agt_config w_cfg;
 wr_driver w_drv;
 wr_monitor w_mon;
 wr_sequencer w_seqr;

extern function new(string name="wr_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

function wr_agent::new(string name="wr_agent",uvm_component parent);
         super.new(name,parent);
endfunction

function void wr_agent::build_phase(uvm_phase phase);
         super.build_phase(phase);
      if(! uvm_config_db #(wr_agt_config)::get(this,"","wr_agt_config",w_cfg))
        `uvm_fatal("wr_agent","getting failed")

         w_mon=wr_monitor::type_id::create("w_mon",this);

       if(w_cfg.is_active)
         begin
 
         w_drv=wr_driver::type_id::create("w_drv",this);
         w_seqr=wr_sequencer::type_id::create("w_seqr",this);
        end        

endfunction

function void wr_agent::connect_phase (uvm_phase phase);
       w_drv.seq_item_port.connect(w_seqr.seq_item_export);
endfunction
