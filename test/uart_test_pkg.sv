package uart_test_pkg;


//import uvm_pkg.sv
	import uvm_pkg::*;
//include uvm_macros.sv
	`include "uvm_macros.svh"
//`include "type_def.sv"

`include "write_xtn.sv"
`include "wr_agt_config.sv"
`include "rd_agt_config.sv"
`include "env_config.sv"

`include "wr_driver.sv"
`include "wr_monitor.sv"
`include "wr_sequencer.sv"
`include "wr_agent.sv"
`include "wr_agt_top.sv"
`include "wr_seqs.sv"

`include "read_xtn.sv"
`include "rd_monitor.sv"
`include "rd_sequencer.sv"
`include "read_seqs.sv"
`include "rd_driver.sv"
`include "rd_agent.sv"
`include "rd_agt_top.sv"

`include "v_sequencer.sv"
`include "v_seqs.sv"
`include "scoreboard.sv"

`include "uart_tb.sv"


`include "test.sv"
endpackage
