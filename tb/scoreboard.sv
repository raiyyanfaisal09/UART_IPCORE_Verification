class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)

uvm_tlm_analysis_fifo #(read_xtn)  fifo_rd;
uvm_tlm_analysis_fifo #(write_xtn) fifo_wr;

extern function new(string name="scoreboard",uvm_component parent);
extern function void build_phase(uvm_phase phase);
//extern function void connect_phase(uvm_phase phase);
endclass

function scoreboard::new(string name="scoreboard",uvm_component parent);
         super.new(name,parent);
endfunction
  
function void scoreboard::build_phase(uvm_phase phase);
         super.build_phase(phase);
         fifo_rd=new("fifo_rd",this);
         fifo_wr=new("fifo_wr",this);
endfunction





















