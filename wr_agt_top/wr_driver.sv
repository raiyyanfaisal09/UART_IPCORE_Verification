class wr_driver extends uvm_driver #(write_xtn);
`uvm_component_utils(wr_driver)

virtual wishbone_if.WR_DR vif;
wr_agt_config w_cfg;
//write_xtn w_xtn;
extern function new(string name="wr_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase (uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send_to_dut(write_xtn w_xtn);
endclass

function wr_driver::new(string name="wr_driver",uvm_component parent);
         super.new(name,parent);
endfunction

function void wr_driver::build_phase(uvm_phase phase);
         if(!uvm_config_db #(wr_agt_config)::get(this,"","wr_agt_config",w_cfg))
            `uvm_fatal("wr_driver","getting failed")
         super.build_phase(phase);
endfunction


function void wr_driver:: connect_phase (uvm_phase phase);
        vif=w_cfg.vif;
endfunction


task wr_driver::run_phase(uvm_phase phase);
            
//==============   reset   ========================
            @(vif.wr_dr_cb);

          vif.wr_dr_cb.wb_rst_i<=1;

            @(vif.wr_dr_cb);

          vif.wr_dr_cb.wb_rst_i<=0;

         rsp=write_xtn::type_id::create("rsp");

          
          forever 
               begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
                rsp.dat_o =vif.wr_dr_cb.wb_dat_o;
              rsp.set_id_info(req);


		seq_item_port.item_done(rsp);
	       end
     
endtask


task wr_driver::send_to_dut(write_xtn w_xtn);
                
          /* `uvm_info("wr_driver","printing write transaction before sending",UVM_LOW)
             w_xtn.print();

     
             $display("befoer wait=========================="); 
         wait(! vif.wr_dr_cb.wb_ack_o)
             begin 
             $display("after wait=========================="); 
        
         // @(vif.wr_dr_cb);
  
        // @(vif.wr_dr_cb);
          
            vif.wr_dr_cb.wb_stb_i<=1;
            vif.wr_dr_cb.wb_we_i<=w_xtn.we;

            // @(vif.wr_dr_cb);

            
            vif.wr_dr_cb.wb_adr_i<=w_xtn.addr;
         // vif.wr_dr_cb.wb_sel_i<=4'd1;

            vif.wr_dr_cb.wb_dat_i<=w_xtn.dat_i;

            
            vif.wr_dr_cb.wb_cyc_i<=1;
           end
       // else
         wait( vif.wr_dr_cb.wb_ack_o)
               begin
                vif.wr_dr_cb.wb_stb_i<=0;
                vif.wr_dr_cb.wb_cyc_i<=0;
                vif.wr_dr_cb.wb_we_i<=0;
             end
           */








if(w_xtn.addr==2 && w_xtn.we==0)
   begin
     wait (vif.wr_dr_cb.int_o)
         begin
           wait(! vif.wr_dr_cb.wb_ack_o)
             begin
               // $display("got   for int_o=============================");
               @(vif.wr_dr_cb);
	         // @(vif.wr_dr_cb);
              //  @(vif.wr_dr_cb);


                vif.wr_dr_cb.wb_we_i<=0;
                 vif.wr_dr_cb.wb_stb_i<=1;
                vif.wr_dr_cb.wb_adr_i<=2'd2;
                vif.wr_dr_cb.wb_cyc_i<=1;
                
                @(vif.wr_dr_cb);
                @(vif.wr_dr_cb);
                @(vif.wr_dr_cb);
               // @(vif.wr_dr_cb);

 



              

            /* case(temp[3:0])
                  4'b0110:$display("check line status flag   temp=%0d",temp);
                  4'b0100:begin
                           $display("receiver data available    temp=%0d",temp);
                               // vif.wr_dr_cb.wb_adr_i<=2'd0;
                                // vif.wr_dr_cb.wb_we_i<=0;
                          end

 
                  4'b1100:$display("time out indication    temp=%0d",temp);
                  4'b0010:begin
                            $display("thr empty    temp=%0d",temp);
                                 @(vif.wr_dr_cb);

                                vif.wr_dr_cb.wb_adr_i<=2'd2;
                                 vif.wr_dr_cb.wb_we_i<=0;
                                vif.wr_dr_cb.wb_cyc_i<=0;
                                vif.wr_dr_cb.wb_stb_i<=0;

                           end
                             
                  4'b0000:$display("modem status    temp=%0d",temp);
                  default:$display("no interrupt    temp=%0d",temp);
             endcase
               $display("after endcase==========================");*/
           end
     end
   end 
        


else 

       begin 
            // $display("before wait==========================");

           wait(! vif.wr_dr_cb.wb_ack_o)
              
           //  $display("after wait=========================="); 
        
         // @(vif.wr_dr_cb);
  
        // @(vif.wr_dr_cb);
          
            vif.wr_dr_cb.wb_stb_i<=1;
            vif.wr_dr_cb.wb_we_i<=w_xtn.we;

           //  @(vif.wr_dr_cb);
         //@(vif.wr_dr_cb);

            
            vif.wr_dr_cb.wb_adr_i<=w_xtn.addr;
            //vif.wr_dr_cb.wb_sel_i<=4'd1;
//@(vif.wr_dr_cb);
//@(vif.wr_dr_cb);


            vif.wr_dr_cb.wb_dat_i<=w_xtn.dat_i;
            
            
            vif.wr_dr_cb.wb_cyc_i<=1;
           
         
        wait( vif.wr_dr_cb.wb_ack_o)
             
                vif.wr_dr_cb.wb_stb_i<=0;
                vif.wr_dr_cb.wb_cyc_i<=0;
                vif.wr_dr_cb.wb_we_i<=0;
                      
              
    end
      





                  //$display("befoer wait=========================="); 
        

//$display("waiting for int_o=============================");

   
      
endtask
          
 

