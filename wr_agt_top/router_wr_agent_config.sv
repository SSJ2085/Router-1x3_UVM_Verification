class router_wr_agent_config extends uvm_object;
	
	`uvm_object_utils(router_wr_agent_config)

	uvm_active_passive_enum is_active = UVM_ACTIVE;

	virtual router_if vif;

	static int drv_data_count = 0;
	static int mon_data_count = 0;

	extern function new(string name="router_wr_agent_config");

endclass


/*****************************************************************************************/

function router_wr_agent_config::new(string name="router_wr_agent_config");
	super.new(name);
endfunction
