class router_wr_seqencer extends uvm_sequencer#(write_xtn);
	`uvm_component_utils(router_wr_seqencer)

	extern function new(string name="router_wr_seqencer",uvm_component parent);
endclass

/*****************************************************************************************/

function router_wr_seqencer::new(string name="router_wr_seqencer",uvm_component parent);
	super.new(name,parent);
endfunction

/******************************************************************************************/

