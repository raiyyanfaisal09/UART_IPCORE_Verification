`timescale 1ns/10ps

module top;


import uvm_pkg::*;
import uart_test_pkg::*;

bit clk1,clk2;
wire stx_o;
wire srx_i;


always
  begin
   
    clk1=1'b1;
    #78.125;
    clk1=~clk1;
    #78.125;
  end



always
  begin
    #156.25; 
    clk2=1'b1;
    #156.25;
    clk2=~clk2;
  end



wishbone_if wb_if1(clk1);
wishbone_if wb_if2(clk2);

uart_top DUV1	(.wb_clk_i(clk1), 
	
	          // Wishbone signals
	          .wb_rst_i(wb_if1.wb_rst_i),     .wb_adr_i(wb_if1.wb_adr_i),       .wb_dat_i(wb_if1.wb_dat_i),     .wb_dat_o(wb_if1.wb_dat_o), 
                  .wb_we_i(wb_if1.wb_we_i),       .wb_stb_i(wb_if1.wb_stb_i),       .wb_cyc_i(wb_if1.wb_cyc_i),      .wb_ack_o(wb_if1.wb_ack_o),                                   .wb_sel_i(wb_if1.wb_sel_i),	  .int_o(wb_if1.int_o),

                    	// serial input/output
	            .stx_pad_o(srx_i),    .srx_pad_i(stx_o)

	                         // modem signals
	                        //rts_pad_o, cts_pad_i, dtr_pad_o, dsr_pad_i, ri_pad_i, dcd_pad_i
	       );



uart_top DUV2	(.wb_clk_i(clk2), 
	
	          // Wishbone signals
	          .wb_rst_i(wb_if2.wb_rst_i),     .wb_adr_i(wb_if2.wb_adr_i),       .wb_dat_i(wb_if2.wb_dat_i),     .wb_dat_o(wb_if2.wb_dat_o), 
                  .wb_we_i(wb_if2.wb_we_i),       .wb_stb_i(wb_if2.wb_stb_i),       .wb_cyc_i(wb_if2.wb_cyc_i),      .wb_ack_o(wb_if2.wb_ack_o),                              .wb_sel_i(wb_if2.wb_sel_i),	 .int_o(wb_if2.int_o),



                    	// serial input/output
	            .stx_pad_o(stx_o),    .srx_pad_i(srx_i)

	                         // modem signals
	                        //rts_pad_o, cts_pad_i, dtr_pad_o, dsr_pad_i, ri_pad_i, dcd_pad_i
	       );





initial
  begin
   
    uvm_config_db #(virtual wishbone_if)::set(null,"*","vifw_0",wb_if1);
    uvm_config_db #(virtual wishbone_if)::set(null,"*","vifr_0",wb_if2);
    run_test();

  end


endmodule


