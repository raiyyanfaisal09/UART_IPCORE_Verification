class rd_monitor extends uvm_monitor;
`uvm_component_utils(rd_monitor)

virtual wishbone_if.RD_MON vif;
rd_agt_config r_cfg; 
uvm_analysis_port #(read_xtn) monitor_port;
read_xtn r_xtn;

extern function new(string name="rd_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase (uvm_phase phase);
extern  task run_phase(uvm_phase phase);
extern task collect_data();


endclass

function rd_monitor::new(string name="rd_monitor",uvm_component parent);
         super.new(name,parent);
         monitor_port=new("monitor_port",this);
endfunction

function void rd_monitor::build_phase(uvm_phase phase);
         super.build_phase(phase);
         if(!uvm_config_db #(rd_agt_config)::get(this,"","rd_agt_config",r_cfg))
            `uvm_fatal("rd_monitor","getting failed")

endfunction

function void rd_monitor:: connect_phase (uvm_phase phase);
        vif=r_cfg.vif;
endfunction



task rd_monitor::run_phase(uvm_phase phase);
      
      forever
         begin
           collect_data();
         end
endtask

task rd_monitor::collect_data();
         r_xtn=read_xtn::type_id::create("r_xtn");

      wait(vif.rd_mon_cb.wb_adr_i==0 && vif.rd_mon_cb.wb_we_i==1)
        begin          
         wait( vif.rd_mon_cb.wb_ack_o)
            begin
        
        // @(vif.wr_mon_cb);
         @(vif.rd_mon_cb);
         
           
             r_xtn.stb=vif.rd_mon_cb.wb_stb_i;

             r_xtn.rst= vif.rd_mon_cb.wb_rst_i;

             r_xtn.addr= vif.rd_mon_cb.wb_adr_i;

            r_xtn.sel=vif.rd_mon_cb.wb_sel_i;

            r_xtn.dat_i= vif.rd_mon_cb.wb_dat_i;

            r_xtn.we=vif.rd_mon_cb.wb_we_i;

            r_xtn.cyc= vif.rd_mon_cb.wb_cyc_i;
                       

           `uvm_info("rd_monitor","data received in rd_monitor before sending to SCOREBOARD",UVM_LOW)
             r_xtn.print() ;  
   end

            monitor_port.write(r_xtn);
            end

endtask
