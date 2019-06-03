class rd_agt_config extends uvm_object;
`uvm_object_utils(rd_agt_config)

virtual wishbone_if vif;

uvm_active_passive_enum is_active=UVM_ACTIVE;

function new(string name="rd_agt_config");
         super.new(name);
endfunction

endclass

