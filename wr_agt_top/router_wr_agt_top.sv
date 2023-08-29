class router_wr_agt_top extends uvm_env;

	`uvm_component_utils(router_wr_agt_top)

	router_env_config cfg;
	//router_wr_agent_config w_cfg[];
	router_wr_agent wagnth[];

	extern function new(string name="router_wr_agt_top",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

/***************************************************************************************/

function router_wr_agt_top::new(string name="router_wr_agt_top",uvm_component parent);
	super.new(name,parent);
endfunction

/**************************************************************************************/


function void router_wr_agt_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",cfg))
		`uvm_fatal("CONFIG","cannot get config data");

	wagnth = new[cfg.no_of_write_agent];
	
	foreach(wagnth[i])
		begin
			wagnth[i] = router_wr_agent::type_id::create($sformatf("wagnth[%0d]",i),this);
			uvm_config_db #(router_wr_agent_config)::set(this,$sformatf("wagnth[%0d]*",i),"router_wr_agent_config",cfg.w_cfg[i]);
		end
endfunction
