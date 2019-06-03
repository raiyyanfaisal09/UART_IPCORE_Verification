class wr_seqs extends uvm_sequence #(write_xtn);
`uvm_object_utils(wr_seqs)



function new(string name="wr_seqs" );
   super.new(name);
endfunction

endclass



//========================first test valid data, i parity, 1 stop bit============================
class vld_w_seqs extends wr_seqs;
`uvm_object_utils(vld_w_seqs)

write_xtn req;
extern function new(string name="vld_w_seqs");
extern task body();
endclass

function vld_w_seqs::new(string name="vld_w_seqs");
      super.new(name);
endfunction


task vld_w_seqs::body();
     
     // super.body();
       req=write_xtn::type_id::create("req");
       rsp=write_xtn::type_id::create("req");

  // $display("creating req===============================================");

 
        //===============set lcr to access divisor latch ==================================================

        begin
          start_item(req);
            // $display("after start_item===============================================");

          assert(req.randomize() with {addr==3;dat_i[7]==1;dat_i[6:4]==0;dat_i[3]==1;dat_i[2]==0;dat_i[1:0]==2'b11;
                                       sel==4'd1;we==1 ;})
          finish_item(req);
      //  get_response(rsp);

       end

  //=================== set diviser latch msb ================0========================================
      
          begin
          start_item(req);                                                              //baud rate 1,00,000 bps; frequency 64Mhz; period 156.25
          assert(req.randomize() with {addr==1;dat_i==0; sel==4'd1;we==1;})
          finish_item(req);
 //get_response(rsp);

       end
//================ set divisor latch lsb =============================================================
       begin
          start_item(req);
          assert(req.randomize() with {addr==0;dat_i==4; sel==4'd1;we==1;})
          finish_item(req);
// get_response(rsp);

       end

//===============set lcr to access other reg ========================================================
     begin
          start_item(req);
          assert(req.randomize() with {addr==3;dat_i[7]==0;dat_i[6:4]==0;dat_i[3]==1;dat_i[2]==0;dat_i[1:0]==2'b11; sel==4'd1;we==1;})
          finish_item(req);
// get_response(rsp);

       end
//=============  set fifo control reg ========================================================
   begin
          start_item(req);
          assert(req.randomize() with {addr==2;dat_i[7:6]==2'b01;dat_i[5:3]==0;dat_i[2]==0;dat_i[1]==0;dat_i[0]==0; sel==4'd1;we==1;})
          finish_item(req);
// get_response(rsp);

       end
//=========== set interrupt enable reg =====================================================
  begin
          start_item(req);
          assert(req.randomize() with {addr==1;dat_i[7:4]==0;dat_i[3]==0;dat_i[2]==1;dat_i[1:0]==2'b11; sel==4'd1;we==1;})
          finish_item(req);
// get_response(rsp);

       end

//repeat(5)

//========== set thr =========================================================================
repeat(1)
  begin
          start_item(req);
          assert(req.randomize() with {addr==0;dat_i inside{[0:255]}; sel==4'd1;we==1;})
          finish_item(req);
// get_response(rsp);
end
     


 /* begin
          start_item(req);
          assert(req.randomize() with {addr==2;sel==4'd1;we==0;})
          finish_item(req);
       end
*/
/*
//$display($time,"now randomize sequence is");
 // req.print();
 //  get_response(rsp);
         $display("printing from read seq");
         //rsp.print();
       //if(rsp.addr==2 && rsp.we==0)
           //begin
              case (rsp.dat_o[3:0])

                  4'b0110:begin
                           $display("check line status flag   iir value=%0d",rsp.dat_o);
                           start_item(req);
                           assert(req.randomize() with {addr==5; sel==4'd1;we==0;})
                           finish_item(req);
 

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








//===================================   Loopback mode =================================//

/*
class loop_w_seqs extends wr_seqs;
`uvm_object_utils(loop_w_seqs)

bit[7:0]temp;

extern function new(string name="loop_w_seqs");
extern task body();

endclass


function loop_w_seqs::new(string name="loop_w_seqs");
   super.new(name);
endfunction



task loop_w_seqs:: body();


rsp=write_xtn::type_id::create("rsp");
req=write_xtn::type_id::create("req");


begin
  $display("configuring lcr to access divisor latch in transmitter ");
  start_item(req);
  assert(req.randomize() with {addr==3;dat_i[7]==1;dat_i[6:5]==0;dat_i[4]==1;dat_i[3]==1;dat_i[2]==0;dat_i[1:0]==2'b11;sel==4'd1;we==1;})
  finish_item(req);
  get_response(rsp);
end


begin
  $display("configuring  divisor latch msb in transmitter ");
  start_item(req);
  assert(req.randomize() with {addr==1;dat_i==0;sel==4'd1;we==1;})
  finish_item(req);
  get_response(rsp);
end



begin
  $display("configuring  divisor latch lsb in transmitter ");
  start_item(req);
  assert(req.randomize() with {addr==1;dat_i==2;sel==4'd1;we==1;})
  finish_item(req);
  get_response(rsp);
end


begin
  $display("configuring lcr to access other registers in transmitter ");
  start_item(req);
  assert(req.randomize() with {addr==3;dat_i[7]==0;dat_i[6:5]==0;dat_i[4]==1;dat_i[3]==1;dat_i[2]==0;dat_i[1:0]==2'b11;sel==4'd1;we==1;})
  finish_item(req);
  get_response(rsp);
end



begin
  $display("configuring interrupt enable reg in transmittert");
  start_item(req);
  assert(req.randomize() with {addr==1;dat_i[7]==0;dat_i[6:5]==0;dat_i[4]==0;dat_i[3]==0;dat_i[2]==1;dat_i[1:0]==2'b11;sel==4'd1;we==1;})
  finish_item(req);
  get_response(rsp);
end


begin
  $display("configuring fifo control reg in transmitter ");
  start_item(req);
  assert(req.randomize() with {addr==2;dat_i[7]==1;dat_i[6:5]==2'b10;dat_i[4]==0;dat_i[3]==0;dat_i[2]==0;dat_i[1:0]==2'b0;sel==4'd1;we==1;})
  finish_item(req);
  get_response(rsp);
end


begin
  $display("configuring modem control reg for loopback mode ");
  start_item(req);
  assert(req.randomize() with {addr==4;dat_i[7]==0;dat_i[6:5]==0;dat_i[4]==1;dat_i[3]==0;dat_i[2]==0;dat_i[1:0]==2'b00;sel==4'd1;we==1;})
  finish_item(req);
  get_response(rsp);
end


repeat(1)
begin
  $display("sending data in transmitter ");
  start_item(req);
  assert(req.randomize() with {addr==0;dat_i inside {[0:255]}; sel==4'd1;we==1;})

//assert(req.randomize() with {addr==0;dat_i inside{[0:255]}; sel==4'd1;we==1;})

  finish_item(req);
  get_response(rsp);
end




begin
  $display(" monitoring iir");
  start_item(req);
  assert(req.randomize() with {addr==2;sel==4'd1;we==0;})
  finish_item(req);
  get_response(rsp);
  rsp.print();

     temp=rsp.dat_o[3:0];

      case(temp)


           4'b0110:begin
                      $display("receiver line status temp=%0b",temp);
                        start_item(req);
 			 assert(req.randomize() with {addr==5;sel==4'd1;we==0;})
			  finish_item(req);
			  get_response(rsp);
 			 rsp.print();
	           end

           4'b0100:begin
			$display("fifo trigger level reached temp=%0b",temp);
			 start_item(req);
  			assert(req.randomize() with {addr==0;sel==4'd1;we==0;})
  			finish_item(req);
  			get_response(rsp);
  			rsp.print();
		   end

           4'b1100:begin
			$display("time out  temp=%0b",temp);
			 start_item(req);
			  assert(req.randomize() with {addr==0;sel==4'd1;we==0;})
  			finish_item(req);
 			 get_response(rsp);
  			rsp.print();
		 end

           4'b0010:begin
			$display("thr empty temp=%0b",temp);
			 start_item(req);
  			assert(req.randomize() with {addr==2;sel==4'd1;we==0;})
  			finish_item(req);
  			get_response(rsp);
  			rsp.print();
		end
           default:$display("no interrupts");
 

       endcase

$display("sending data in loop back ");


end

endtask

*/






















