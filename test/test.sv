class test extends uvm_test;
  `uvm_component_utils(test)
   
   env_config e_cfg;
   wr_agt_config w_agt_test_cfg[];
   rd_agt_config r_agt_test_cfg[];
   uart_tb env;
   
extern function new(string name="test",uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function test::new(string name="test",uvm_component parent);
              super.new(name,parent);
endfunction

function void test::build_phase(uvm_phase phase);
               super.build_phase(phase);
              e_cfg=env_config::type_id::create("e_cfg");
              
             
	      e_cfg.has_sb=1;
              e_cfg.has_vseqr=1;
              e_cfg.no_of_wagt=1;
              e_cfg.no_of_ragt=1;
              e_cfg.no_of_wtop=1;
              e_cfg.no_of_rtop=1;

              w_agt_test_cfg=new[e_cfg.no_of_wagt];
              r_agt_test_cfg=new[e_cfg.no_of_ragt];


              e_cfg.w_cfg=new[e_cfg.no_of_wagt];
              e_cfg.r_cfg=new[e_cfg.no_of_ragt];

              foreach(w_agt_test_cfg[i])
                 begin
                    w_agt_test_cfg[i]=wr_agt_config::type_id::create($sformatf("w_agt_test_cfg[%0d]",i));

                    if(!uvm_config_db #(virtual wishbone_if)::get(this,"",$sformatf("vifw_%0d",i),w_agt_test_cfg[i].vif))
                       `uvm_fatal("test","getting interface failed")
               

                                     w_agt_test_cfg[i].is_active=UVM_ACTIVE;
                 
                   e_cfg.w_cfg[i]=w_agt_test_cfg[i];
                 end


              foreach(r_agt_test_cfg[i])
                 begin
                     r_agt_test_cfg[i]=rd_agt_config::type_id::create($sformatf("r_agt_test__cfg[%0d]",i));

                if(!uvm_config_db #(virtual wishbone_if)::get(this,"",$sformatf("vifr_%0d",i),r_agt_test_cfg[i].vif))
                       `uvm_fatal("test","getting interface failed")

                                     r_agt_test_cfg[i].is_active=UVM_ACTIVE;
                 
                   e_cfg.r_cfg[i]=r_agt_test_cfg[i];
                 end

            uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);
              env=uart_tb::type_id::create("uart_tb",this);

endfunction



//==================================  first test case valid data ====================
class vld_test extends test;
`uvm_component_utils(vld_test)

vld_v_seqs v_seqs;

function new(string name="vld_test",uvm_component parent);
      super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction


task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    v_seqs=vld_v_seqs::type_id::create("v_seqs");
 $display($time,"in test--------------------------"); 

    v_seqs.start(env.v_seqr);
#10000;
   phase.drop_objection(this);
endtask


endclass
  


//================================== loopback test case ===============================
/*
class loop_test extends test;
`uvm_component_utils(loop_test)

loop_v_seqs v_seqs;

function new(string name="loop_test", uvm_component parent);
    super.new(name, parent);
endfunction


function void build_phase(uvm_phase phase);
      super.build_phase(phase);
endfunction

task run_phase(uvm_phase phase);
 phase.raise_objection(this);
  v_seqs=loop_v_seqs::type_id::create("v_seqs");
  v_seqs.start(env.v_seqr);
#100000;
  phase.drop_objection(this);
endtask

endclass
*/













