class v_sequencer extends uvm_sequencer #(uvm_sequence_item);
`uvm_component_utils(v_sequencer)


wr_sequencer w_seqr[];
rd_sequencer r_seqr[];
env_config e_cfg;

extern function new(string name="v_sequencer",uvm_component parent);
extern function void build_phase(uvm_phase phase); 
endclass

function v_sequencer::new(string name="v_sequencer",uvm_component parent);
         super.new(name,parent);
endfunction



function void v_sequencer:: build_phase(uvm_phase phase); 
           super.build_phase(phase);
          if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
            `uvm_fatal("v_sequencer","getting failed")

        w_seqr=new[e_cfg.no_of_wagt];
        r_seqr=new[e_cfg.no_of_ragt];

endfunction













