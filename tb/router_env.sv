class router_env extends uvm_env;
	`uvm_component_utils(router_env);
	router_env_config cfg;
	//router_scoreboard sb;
	router_virtual_sequencer v_seqr;
	router_wr_agt_top wagt_top;
	router_rd_agt_top ragt_top;

	extern function new(string name="router_env",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass

/************************************************************************************************/


function router_env::new(string name="router_env",uvm_component parent);
	super.new(name,parent);
endfunction


/************************************************************************************************/

function void router_env::build_phase(uvm_phase phase);
	if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",cfg))
		`uvm_fatal("CONFIG","cannot get config data");
	super.build_phase(phase);

	if(cfg.has_wagent)
		begin
			wagt_top = router_wr_agt_top::type_id::create("wagt_top",this);

		end
	if(cfg.has_ragent)
		begin
			
			ragt_top = router_rd_agt_top::type_id::create("ragt_top",this);
		end
	if(cfg.has_virtual_sequencer)
		begin
			v_seqr = router_virtual_sequencer::type_id::create("v_seqr",this);
		end
endfunction


/***********************************************************************************************/

function void router_env::connect_phase(uvm_phase phase);
	if(cfg.has_virtual_sequencer)

		begin
			if(cfg.has_wagent)
				begin
					for(int i=0;i<cfg.no_of_write_agent;i++)
						begin
							v_seqr.wr_seqrh[i] = wagt_top.wagnth[i].m_sequencer;
						end
				end

		
			if(cfg.has_ragent)
				begin
					for(int i=0;i<cfg.no_of_read_agent;i++)
						begin
							v_seqr.rd_seqrh[i] = ragt_top.ragnth[i].m_sequencer;
						end
				end


		end

	
endfunction
