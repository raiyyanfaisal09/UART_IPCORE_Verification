class rd_seqs extends uvm_sequence #(read_xtn);
`uvm_object_utils(rd_seqs)

function new(string name="rd_seqs" );
   super.new(name);
endfunction

endclass



//========================first test valid data, i parity, 1 stop bit============================

class vld_r_seqs extends rd_seqs;
 `uvm_object_utils(vld_r_seqs)

  read_xtn req;
extern function new(string name="vld_r_seqs");
extern task body();
endclass

function vld_r_seqs::new(string name="vld_r_seqs");
      super.new(name);
endfunction


task vld_r_seqs::body();
     
     // super.body();
       req=read_xtn::type_id::create("req");
  // $display("creating req===============================================");

    //===============set lcr to access divisor latch ==================================================
        begin
          start_item(req);
            // $display("after start_item===============================================");

          assert(req.randomize() with {addr==3;dat_i[7]==1;dat_i[6:4]==0;dat_i[3]==1;dat_i[2]==0;dat_i[1:0]==2'b11;
                                       sel==4'd1;we==1;})
          
          finish_item(req);
          get_response(rsp);
 rsp.print();


       end

  //=================== set diviser latch msb ================0========================================
      
          begin
          start_item(req);                                                              //baud rate 1,00,000 bps; frequency 64Mhz; period 156.25
          assert(req.randomize() with {addr==1;dat_i==0; sel==4'd1;we==1;})
          finish_item(req);
get_response(rsp);
 rsp.print();


       end
//================ set divisor latch lsb =============================================================
       begin
          start_item(req);
          assert(req.randomize() with {addr==0;dat_i==2; sel==4'd1;we==1;})
          finish_item(req);
get_response(rsp);
 rsp.print();


       end

//===============set lcr to access other reg ========================================================
     begin
          start_item(req);
          assert(req.randomize() with {addr==3;dat_i[7]==0;dat_i[6:5]==0;dat_i[4]==1;dat_i[3]==1;dat_i[2]==0;dat_i[1:0]==2'b11; sel==4'd1;we==1;})
          finish_item(req);
get_response(rsp);
 rsp.print();


       end
//=============  set fifo control reg ========================================================
   begin
          start_item(req);
          assert(req.randomize() with {addr==2;dat_i[7:6]==2'b01;dat_i[5:3]==0;dat_i[2]==0;dat_i[1]==0;dat_i[0]==0; sel==4'd1;we==1;})
          finish_item(req);
get_response(rsp);
 rsp.print();


       end
//=========== set interrupt enable reg =====================================================
  begin
          start_item(req);
          assert(req.randomize() with {addr==1;dat_i[7:4]==0;dat_i[3]==0;dat_i[2]==1;dat_i[1:0]==2'b01; sel==4'd1;we==1;})
          finish_item(req);
          get_response(rsp);
    rsp.print();


       end

//========== set rbuf =========================================================================
       begin
          start_item(req);
          assert(req.randomize() with {addr==2; sel==4'd1;we==0;})
          finish_item(req);
          get_response(rsp);
         $display("printing from read seq");
         //rsp.print();
       // if(rsp.addr==2 && rsp.we==0)
           //begin
           
              case (rsp.dat_o[3:0])

                  4'b0110:begin
                        
                           $display("check line status flag   iir value=%0d",rsp.dat_o);
                           start_item(req);

                         
                        
                           assert(req.randomize() with {addr==5; sel==4'd1;we==0;})
                           finish_item(req);

		//	if(rsp.addr==5 && rsp.we==0)
                          
                         get_response(rsp);
                        
                          rsp.print();
                            
                              // (rsp.addr==5 && rsp.we==0)

                                              begin
                                                 if(rsp.dat_o[2])
                                                    $display("==================== parity error   data_out=%0d ==============",rsp.dat_o);

                                                 if(rsp.dat_o[3])
                                                     $display("==================== framing error ==============");

                                                 if(rsp.dat_o[4])
                                                     $display("==================== break interrupt ==============");

       					       	 if(rsp.dat_o[6])
                                                     $display("==================== transmitter empty ==============");

                				 if(rsp.dat_o[5])
                                                     $display("==================== transmitter fifo empty ==============");

						 if(rsp.dat_o[1])
                                                     $display("==================== overrun error ==============");

						if(rsp.dat_o[0])
                                                     $display("==================== data ready indicator ==============");

                                            	if(rsp.dat_o[7])
                                                     $display("==================== at least one error ==============");
                			      end                                      

                                 
                                          

                                 
                                          end
                       

                  4'b0100:begin

                            $display("receiver data available    temp=%0d",rsp.dat_o);
                            start_item(req);
                            assert(req.randomize() with {addr==0; sel==4'd1;we==0;})
                            finish_item(req);
                           get_response(rsp);
                           rsp.print();

                          end

 
                  4'b1100:begin

                            $display("time out indication    temp=%0d",rsp.dat_o);
                            start_item(req);
                            assert(req.randomize() with {addr==0; sel==4'd1;we==0;})
                            finish_item(req);
                            get_response(rsp);
                           rsp.print();

                          end

                  4'b0010:begin
                            $display("thr empty    temp=%0d",rsp.dat_o);
                            start_item(req);
                            assert(req.randomize() with {addr==2; sel==4'd1;we==0;})
                            finish_item(req);
                          end
                             
                  4'b0000:$display("modem status    temp=%0d",rsp.dat_o);
                  default:$display("no interrupt    temp=%0d",rsp.dat_o);
             endcase

           // end
	 end

/* repeat(1)     
begin
 start_item(req);
                            assert(req.randomize() with {addr==0; sel==4'd1;we==0;})
                            finish_item(req);
            get_response(rsp);
                           rsp.print();

end
  
//$display($time,"now randomize sequence is");
 // req.print();*/


endtask











