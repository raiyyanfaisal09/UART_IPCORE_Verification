class write_xtn extends uvm_sequence_item;
`uvm_object_utils(write_xtn)

rand bit rst;
rand bit [2:0]addr;
rand bit [3:0]sel;
rand bit [7:0]dat_i;
rand bit [7:0]dat_o;
rand bit we;
bit stb;
bit cyc;


 
constraint RESET {rst==0;}


extern function new(string name="write_xtn");
extern function void do_print(uvm_printer printer);
endclass

function write_xtn:: new(string name="write_xtn");
         super.new(name);
endfunction

function void write_xtn:: do_print(uvm_printer printer);

printer.print_field("reset",	  	rst,		1,	UVM_DEC);
printer.print_field("reg address",	addr,		3,	UVM_DEC);
printer.print_field("select",		sel,		4,	UVM_DEC);
printer.print_field("input data",	dat_i,		8,	UVM_DEC);
printer.print_field("output data",	dat_o,		8,	UVM_DEC);
printer.print_field("write enable",	we,		1,	UVM_DEC);
printer.print_field("strobe input",	stb,		1,	UVM_DEC);
printer.print_field("bus cycle",	cyc,		1,	UVM_DEC);
endfunction
