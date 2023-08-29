class router_rd_agt_top extends uvm_env;

        `uvm_component_utils(router_rd_agt_top)

        router_env_config cfg;
        //router_wr_agent_config w_cfg[];
        router_rd_agent ragnth[];

        extern function new(string name="router_rd_agt_top",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
endclass

/***************************************************************************************/

function router_rd_agt_top::new(string name="router_rd_agt_top",uvm_component parent);
        super.new(name,parent);
endfunction

/**************************************************************************************/


function void router_rd_agt_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
        if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",cfg))
                `uvm_fatal("CONFIG","cannot get config data")
	$display("RD AGT TOP ecfg %p",cfg);
        ragnth = new[cfg.no_of_read_agent];

        foreach(ragnth[i])
                begin
                        ragnth[i]= router_rd_agent::type_id::create($sformatf("ragnth[%0d]",i),this);
                        uvm_config_db #(router_rd_agent_config)::set(this,$sformatf("ragnth[%0d]*",i),"router_rd_agent_config",cfg.r_cfg[i]);
						$display("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! %p",cfg.r_cfg[i]);
                end
endfunction

