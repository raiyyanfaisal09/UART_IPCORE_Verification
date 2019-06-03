class rd_driver extends uvm_driver #(read_xtn);
`uvm_component_utils(rd_driver)

rd_agt_config r_cfg;
virtual wishbone_if.RD_DR vif;

extern function new(string name="rd_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase (uvm_phase phase);

extern task run_phase(uvm_phase phase);
extern task send_to_dut(read_xtn r_xtn);
endclass 

function rd_driver::new(string name="rd_driver",uvm_component parent);
         super.new(name,parent);
endfunction

function void rd_driver::build_phase(uvm_phase phase);
         super.build_phase(phase);
          if(!uvm_config_db #(rd_agt_config)::get(this,"","rd_agt_config",r_cfg))
            `uvm_fatal("rd_driver","getting failed")

endfunction

function void rd_driver:: connect_phase (uvm_phase phase);
        vif=r_cfg.vif;
endfunction



task rd_driver::run_phase(uvm_phase phase);

//==============   reset   ========================
          vif.rd_dr_cb.wb_rst_i<=1;

         @(vif.rd_dr_cb);
          @(vif.rd_dr_cb);

          vif.rd_dr_cb.wb_rst_i<=0;

        
               rsp=read_xtn::type_id::create("rsp");
 

                 forever 
               begin
                
                  //rsp.set_id_info(req);

		seq_item_port.get_next_item(req);
                send_to_dut(req);
                 @(vif.rd_dr_cb);
		 @(vif.rd_dr_cb);


                  rsp.dat_o =vif.rd_dr_cb.wb_dat_o;

                 rsp.set_id_info(req);
                                // $display("printing rsp");rsp.print();
          	//seq_item_port.put_response(rsp);
                seq_item_port.item_done(rsp);
	       end
     
endtask


task rd_driver::send_to_dut( read_xtn r_xtn);
           //bit [7:0]temp;
           `uvm_info("rd_driver","printing read transaction before sending",UVM_LOW)
             r_xtn.print();
if(r_xtn.addr==2 && r_xtn.we==0)
   begin
     wait (vif.rd_dr_cb.int_o)
         begin
           wait(! vif.rd_dr_cb.wb_ack_o)
             begin
               // $display("got   for int_o=============================");
               @(vif.rd_dr_cb);
	         // @(vif.rd_dr_cb);
              //  @(vif.rd_dr_cb);


                vif.rd_dr_cb.wb_we_i<=0;
                 vif.rd_dr_cb.wb_stb_i<=1;
                vif.rd_dr_cb.wb_adr_i<=2'd2;
                vif.rd_dr_cb.wb_cyc_i<=1;
                
                @(vif.rd_dr_cb);
                @(vif.rd_dr_cb);
                @(vif.rd_dr_cb);
                @(vif.rd_dr_cb);

 



              

            /* case(temp[3:0])
                  4'b0110:$display("check line status flag   temp=%0d",temp);
                  4'b0100:begin
                           $display("receiver data available    temp=%0d",temp);
                               // vif.rd_dr_cb.wb_adr_i<=2'd0;
                                // vif.rd_dr_cb.wb_we_i<=0;
                          end

 
                  4'b1100:$display("time out indication    temp=%0d",temp);
                  4'b0010:begin
                            $display("thr empty    temp=%0d",temp);
                                 @(vif.rd_dr_cb);

                                vif.rd_dr_cb.wb_adr_i<=2'd2;
                                 vif.rd_dr_cb.wb_we_i<=0;
                                vif.rd_dr_cb.wb_cyc_i<=0;
                                vif.rd_dr_cb.wb_stb_i<=0;

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

           wait(! vif.rd_dr_cb.wb_ack_o)
              
           //  $display("after wait=========================="); 
        
         // @(vif.wr_dr_cb);
  
        // @(vif.rd_dr_cb);
          
            vif.rd_dr_cb.wb_stb_i<=1;
            vif.rd_dr_cb.wb_we_i<=r_xtn.we;

           //  @(vif.rd_dr_cb);
         //@(vif.rd_dr_cb);

            
            vif.rd_dr_cb.wb_adr_i<=r_xtn.addr;
            //vif.rd_dr_cb.wb_sel_i<=4'd1;
//@(vif.rd_dr_cb);
//@(vif.rd_dr_cb);


            vif.rd_dr_cb.wb_dat_i<=r_xtn.dat_i;
            
            
            vif.rd_dr_cb.wb_cyc_i<=1;
           
         
        wait( vif.rd_dr_cb.wb_ack_o)
             
                vif.rd_dr_cb.wb_stb_i<=0;
                vif.rd_dr_cb.wb_cyc_i<=0;
                vif.rd_dr_cb.wb_we_i<=0;
                      
              
    end
      



                  //$display("befoer wait=========================="); 
        

//$display("waiting for int_o=============================");

   
      
endtask
