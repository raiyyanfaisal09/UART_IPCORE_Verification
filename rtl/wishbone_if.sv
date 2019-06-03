

interface wishbone_if(input bit clk);
logic wb_rst_i;
logic [2:0]wb_adr_i;  //define address as 5 or 3 as `define
logic [7:0]wb_dat_i;   //define data as 32 or 8 as `define
logic [7:0]wb_dat_o;  //define data as 32 or 8 as 
logic int_o;
logic baud_o;

logic wb_we_i;
logic wb_stb_i;
logic wb_cyc_i;
logic wb_ack_o;
logic [3:0]wb_sel_i;

clocking wr_dr_cb @(posedge clk);
input wb_ack_o,wb_dat_o,int_o;
output wb_rst_i,wb_adr_i,wb_dat_i,wb_we_i,wb_stb_i,wb_cyc_i,wb_sel_i;
endclocking

clocking wr_mon_cb @(posedge clk);
input wb_dat_o,wb_rst_i,wb_adr_i,wb_dat_i,wb_we_i,wb_stb_i,wb_cyc_i,wb_sel_i,wb_ack_o;
endclocking



clocking rd_dr_cb @(posedge clk);
input wb_ack_o,wb_dat_o,int_o;
output wb_rst_i,wb_adr_i,wb_dat_i,wb_we_i,wb_stb_i,wb_cyc_i,wb_sel_i;
endclocking

clocking rd_mon_cb @(posedge clk);
input wb_dat_o,wb_rst_i,wb_adr_i,wb_dat_i,wb_we_i,wb_stb_i,wb_cyc_i,wb_sel_i,wb_ack_o;
endclocking


modport WR_DR(clocking wr_dr_cb);
modport WR_MON(clocking wr_mon_cb);
modport RD_DR(clocking rd_dr_cb);
modport RD_MON(clocking rd_mon_cb);


endinterface








