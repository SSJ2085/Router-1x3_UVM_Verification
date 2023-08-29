class router_wr_agent extends uvm_agent;

	`uvm_component_utils(router_wr_agent)

	router_wr_driver drvh;
	router_wr_monitor monh;
	router_wr_agent_config w_cfg;
	router_wr_seqencer m_sequencer;


	extern function new(string name="router_wr_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass

/*********************************************************************************************************/


function router_wr_agent::new(string name="router_wr_agent",uvm_component parent);
	super.new(name,parent);
endfunction

/**********************************************************************************************************/

function void router_wr_agent::build_phase(uvm_phase phase);
	if(!uvm_config_db #(router_wr_agent_config)::get(this,"","router_wr_agent_config",w_cfg))
		`uvm_fatal("CONFIG","cannot get config data");
	super.build_phase(phase);
	monh=router_wr_monitor::type_id::create("monh",this);
	if(w_cfg.is_active==UVM_ACTIVE)
		begin
		m_sequencer=router_wr_seqencer::type_id::create("m_sequencer",this);
		drvh=router_wr_driver::type_id::create("drvh",this);
		end
endfunction


/*******************************************************************************************************/

function void router_wr_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	drvh.seq_item_port.connect(m_sequencer.seq_item_export);
endfunction

/*****************************************************************************************************/

