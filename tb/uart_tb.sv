class uart_tb extends uvm_env;

`uvm_component_utils(uart_tb)
  v_sequencer v_seqr;
  scoreboard sb;
  wr_agt_top w_top[];
  rd_agt_top r_top[];

  env_config e_tb_cfg;
 // wr_agt_config w_tb_cfg[];
  //rd_agt_config r_tb_cfg[];

extern function new(string name="uart_tb",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass


function uart_tb::new(string name="uart_tb",uvm_component parent);
         super.new(name,parent);
endfunction

function void uart_tb::build_phase(uvm_phase phase);
         super.build_phase(phase);
        
        if(! uvm_config_db #(env_config)::get(this,"","env_config", e_tb_cfg))
          `uvm_fatal("uart_tb","getting failed")

        if(e_tb_cfg.has_sb)
          begin
            sb=scoreboard::type_id::create("sb",this);
          end
        
        if(e_tb_cfg.has_vseqr)
          begin
           v_seqr=v_sequencer::type_id::create("v_seqr",this);
          end

    //  w_tb_cfg=new[e_tb_cfg.no_of_wagt];
    
       foreach(e_tb_cfg.w_cfg[i])
        begin
           uvm_config_db #(wr_agt_config)::set(this,$sformatf("w_top[%0d].*",i),"wr_agt_config",e_tb_cfg.w_cfg[i]);
        end
             w_top=new[e_tb_cfg.no_of_wtop];
          foreach(w_top[i])
          begin
            w_top[i]=wr_agt_top::type_id::create($sformatf("w_top[%0d]",i),this);
          end
 
       

   //  r_tb_cfg=new[e_tb_cfg.no_of_ragt];
    
       foreach(e_tb_cfg.r_cfg[i])
        begin
           uvm_config_db #(rd_agt_config)::set(this,$sformatf("r_top[%0d].*",i),"rd_agt_config",e_tb_cfg.r_cfg[i]);
        end

       r_top=new[e_tb_cfg.no_of_rtop];
 
       foreach(r_top[i])
          begin
            r_top[i]=rd_agt_top::type_id::create($sformatf("r_top[%0d]",i),this);
          end

endfunction

function void uart_tb::end_of_elaboration_phase(uvm_phase phase);
          uvm_top.print_topology();
endfunction



function void uart_tb::connect_phase(uvm_phase phase);
         foreach(w_top[j])
               // for(int j=0;j<e_tb_cfg.no_of_wtop;j++)
             begin
                for(int i=0;i<e_tb_cfg.no_of_wagt;i++)
                   begin
                        v_seqr.w_seqr[i]=w_top[j].wagt[i].w_seqr;
                        w_top[j].wagt[i].w_mon.monitor_port.connect(sb.fifo_wr.analysis_export);
                    end
          end

      foreach(r_top[j])
             //   for(int i=0;i<e_tb_cfg.no_of_rtop;i++)
             begin
                for(int i=0;i<e_tb_cfg.no_of_ragt;i++)
               //foreach(e_tb_cfg.r_cfg[j])
                  begin
                      v_seqr.r_seqr[i]=r_top[j].ragt[i].r_seqr;
                      r_top[j].ragt[i].r_mon.monitor_port.connect(sb.fifo_rd.analysis_export);
            end
           end
endfunction
       
                 

