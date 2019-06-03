class env_config extends uvm_object;
`uvm_object_utils(env_config)

bit has_sb=1;
bit has_vseqr=1;
int no_of_wagt=1;
int no_of_ragt=1;
int no_of_wtop=1;
int no_of_rtop=1;

rd_agt_config r_cfg[];
wr_agt_config w_cfg[];

function new(string name="env_config");
         super.new(name);
endfunction

endclass
