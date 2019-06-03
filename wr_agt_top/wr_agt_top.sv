class wr_agt_top extends uvm_env;
`uvm_component_utils(wr_agt_top)

  wr_agent wagt[];
  env_config e_cfg;
  

extern function new(string name="wr_agt_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function wr_agt_top::new(string name="wr_agt_top",uvm_component parent);
         super.new(name,parent);
endfunction

function void wr_agt_top::build_phase(uvm_phase phase);
              super.build_phase(phase);
         if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
            `uvm_fatal("wr_agt_top","getting failed ")
         
         wagt=new[e_cfg.no_of_wagt];

         foreach(wagt[i])
              wagt[i]=wr_agent::type_id::create($sformatf("wagt[%0d]",i),this);            

         
endfunction


