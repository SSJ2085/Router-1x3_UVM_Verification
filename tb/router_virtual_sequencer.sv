class router_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

	`uvm_component_utils(router_virtual_sequencer)

	router_wr_seqencer wr_seqrh[];
	router_rd_seqencer rd_seqrh[];
	router_env_config  m_cfg;
		
	extern function new(string name="router_virtual_sequence",uvm_component parent);
	extern function void build_phase(uvm_phase phase);

endclass


/********************************************************************************************************/

function router_virtual_sequencer::new(string name="router_virtual_sequence",uvm_component parent);
	super.new(name,parent);
endfunction

/***************************************************************************************************/

function void router_virtual_sequencer::build_phase(uvm_phase phase);
	
	super.build_phase(phase);
	if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
		`uvm_fatal("VIRTUAL_SEQUENCER","cannot get config data");
	wr_seqrh = new[m_cfg.no_of_write_agent];
	rd_seqrh = new[m_cfg.no_of_read_agent];
endfunction
