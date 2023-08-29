class router_rd_seqencer extends uvm_sequencer#(read_xtn);
        `uvm_component_utils(router_rd_seqencer)

        extern function new(string name="router_rd_seqencer",uvm_component parent);
endclass

/*****************************************************************************************/

function router_rd_seqencer::new(string name="router_rd_seqencer",uvm_component parent);
        super.new(name,parent);
endfunction

/******************************************************************************************/

