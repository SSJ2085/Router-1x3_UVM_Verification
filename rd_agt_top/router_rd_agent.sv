class router_rd_agent extends uvm_agent;

	`uvm_component_utils(router_rd_agent)

	router_rd_driver drvh;
	router_rd_monitor monh;
	router_rd_agent_config r_cfg;
	router_rd_seqencer m_sequencer;


	extern function new(string name="router_rd_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass

/*********************************************************************************************************/


function router_rd_agent::new(string name="router_rd_agent",uvm_component parent);
	super.new(name,parent);
endfunction

/**********************************************************************************************************/

function void router_rd_agent::build_phase(uvm_phase phase);
	if(!uvm_config_db #(router_rd_agent_config)::get(this,"","router_rd_agent_config",r_cfg))
		`uvm_fatal("CONFIG","cannot get config data");
	super.build_phase(phase);
	monh=router_rd_monitor::type_id::create("monh",this);
	if(r_cfg.is_active==UVM_ACTIVE)
		begin
		m_sequencer=router_rd_seqencer::type_id::create("m_sequencer",this);
		drvh=router_rd_driver::type_id::create("drvh",this);
		end
endfunction


/*******************************************************************************************************/

function void router_rd_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	drvh.seq_item_port.connect(m_sequencer.seq_item_export);
endfunction

/*****************************************************************************************************/


