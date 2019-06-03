class wr_monitor extends uvm_monitor;
`uvm_component_utils(wr_monitor)

virtual wishbone_if.WR_MON vif;
wr_agt_config w_cfg; 
uvm_analysis_port #(write_xtn) monitor_port;
write_xtn w_xtn;

extern function new(string name="wr_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
endclass

function wr_monitor::new(string name="wr_monitor",uvm_component parent);
         super.new(name,parent);
          monitor_port=new("monitor_port",this);

endfunction

function void wr_monitor::build_phase(uvm_phase phase);
         super.build_phase(phase);
      if(!uvm_config_db #(wr_agt_config)::get(this,"","wr_agt_config",w_cfg))
            `uvm_fatal("wr_monitor","getting failed")

endfunction


function void wr_monitor:: connect_phase (uvm_phase phase);
        vif=w_cfg.vif;
endfunction


task wr_monitor::run_phase(uvm_phase phase);
      
      forever
         begin
           collect_data();
         end
endtask

task wr_monitor::collect_data();
         w_xtn=write_xtn::type_id::create("w_xtn");

      wait(vif.wr_mon_cb.wb_adr_i==0 && vif.wr_mon_cb.wb_we_i==1)
        begin          
         wait( vif.wr_mon_cb.wb_ack_o)
            begin
        
        // @(vif.wr_mon_cb);
         @(vif.wr_mon_cb);
         
           
             w_xtn.stb=vif.wr_mon_cb.wb_stb_i;

             w_xtn.rst= vif.wr_mon_cb.wb_rst_i;

             w_xtn.addr= vif.wr_mon_cb.wb_adr_i;

            w_xtn.sel=vif.wr_mon_cb.wb_sel_i;

            w_xtn.dat_i= vif.wr_mon_cb.wb_dat_i;

            w_xtn.we=vif.wr_mon_cb.wb_we_i;

            w_xtn.cyc= vif.wr_mon_cb.wb_cyc_i;
                       

           `uvm_info("wr_monitor","data received in wr_monitor before sending to SCOREBOARD",UVM_LOW)
             w_xtn.print() ;  
   end

            monitor_port.write(w_xtn);
            end

endtask
