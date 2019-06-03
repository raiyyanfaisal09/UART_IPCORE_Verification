class rd_agt_top extends uvm_env;
`uvm_component_utils(rd_agt_top)

 rd_agent ragt[];
 env_config e_cfg;

extern function new(string name="rd_agt_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function rd_agt_top::new(string name="rd_agt_top",uvm_component parent);
         super.new(name,parent);
endfunction

function void rd_agt_top::build_phase(uvm_phase phase);
              super.build_phase(phase);

           if(! uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
              `uvm_fatal("rd_agt_top","getting failed")

            ragt=new[e_cfg.no_of_ragt];
             foreach(ragt[i])  
                ragt[i]=rd_agent::type_id::create($sformatf("ragt[%0d]",i),this);            

endfunction










