class v_seqs_base extends uvm_sequence #(uvm_sequence_item);
`uvm_object_utils(v_seqs_base)

wr_sequencer w_seqr[];

rd_sequencer r_seqr[];

vld_w_seqs val_seqs;

vld_r_seqs val_rseqs;

v_sequencer v_seqr;
env_config e_cfg;





function new(string name="v_seqs_base");
     super.new(name);
endfunction


 task body();
    if(!uvm_config_db #(env_config)::get(null, get_full_name(),"env_config",e_cfg))
       `uvm_fatal("virtual seqs ","getting failed")

   w_seqr=new[e_cfg.no_of_wagt];
   r_seqr=new[e_cfg.no_of_ragt];

 if(!$cast(v_seqr,m_sequencer))
   `uvm_fatal("virtual sequence ","casting failed")

  foreach(w_seqr[i])
        w_seqr[i]=v_seqr.w_seqr[i];

  foreach(r_seqr[i])
       r_seqr[i]=v_seqr.r_seqr[i];
 
endtask

endclass



//================================1 st v sequence case ==================

class vld_v_seqs extends v_seqs_base;
`uvm_object_utils(vld_v_seqs)

vld_w_seqs val_seqs;

vld_r_seqs val_rseqs;

function new(string name="vld_v_seqs");
      super.new(name);
endfunction


task body();
  super.body();
  val_seqs=vld_w_seqs::type_id::create("val_seqs");
  
  val_rseqs=vld_r_seqs::type_id::create("val_rseqs");

  $display("before starting virtual sequence============");


fork
  
  foreach(w_seqr[i])
               val_seqs.start(w_seqr[i]);
  
      // $display("after starting virtual sequence============");
 foreach(r_seqr[i])
       val_rseqs.start(r_seqr[i]);

join

endtask
endclass



//=============================================== loopback ========================================

/*
class loop_v_seqs extends v_seqs_base;
`uvm_object_utils(loop_v_seqs)


loop_w_seqs w_seqs;

function new(string name="loop_v_seqs" );
         super.new(name);
endfunction


task body();
   super.body();
w_seqs=loop_w_seqs::type_id::create("w_seqs");

foreach(w_seqr[i])
       w_seqs.start(w_seqr[i]);
endtask
endclass
*/

