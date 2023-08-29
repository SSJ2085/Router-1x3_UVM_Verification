class router_rd_seqs extends uvm_sequence #(read_xtn);

	`uvm_object_utils(router_rd_seqs)

	extern function new(string name="router_rd_seqs");
endclass

/***************************************************************************/

function router_rd_seqs::new(string name="router_rd_seqs");
	super.new(name);
endfunction

/******************************************************************************************************/

class router_rxtns_pkt extends router_rd_seqs;
	`uvm_object_utils(router_rxtns_pkt)


	extern function new(string name="router_rxtns_pkt");
	extern task body();
endclass

/***************************************************************************/

function router_rxtns_pkt::new(string name="router_rxtns_pkt");
        super.new(name);
endfunction

/****************************************************************************/
task router_rxtns_pkt::body();
	
	req = read_xtn::type_id::create("req");

	start_item(req);
	assert(req.randomize() with {no_of_cycles inside{[1:28]};});

	`uvm_info("router_rd_seqence",$sformatf("printing from sequence \n %s",req.sprint()),UVM_LOW)
	finish_item(req);
endtask


/*******************************************************************************************************/


