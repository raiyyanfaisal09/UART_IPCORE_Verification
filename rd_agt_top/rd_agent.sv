class rd_agent extends uvm_agent;
`uvm_component_utils(rd_agent)

 rd_agt_config r_cfg;

 rd_driver r_drv;
 rd_monitor r_mon;
 rd_sequencer r_seqr;

extern function new(string name="rd_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase (uvm_phase phase);
 

endclass

function rd_agent::new(string name="rd_agent",uvm_component parent);
         super.new(name,parent);
endfunction

function void rd_agent::build_phase(uvm_phase phase);
         super.build_phase(phase);

         if(!uvm_config_db #(rd_agt_config)::get(this,"","rd_agt_config",r_cfg))
           `uvm_fatal("rd_agent","getting failed")


         r_mon=rd_monitor::type_id::create("r_mon",this);
       if(r_cfg.is_active)
         begin
         r_drv=rd_driver::type_id::create("r_drv",this);
         r_seqr=rd_sequencer::type_id::create("r_seqr",this);
         end


endfunction


function void rd_agent::connect_phase (uvm_phase phase);
       r_drv.seq_item_port.connect(r_seqr.seq_item_export);
endfunction
