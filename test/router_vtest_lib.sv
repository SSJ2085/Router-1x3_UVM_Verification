class router_test extends uvm_test;

	`uvm_component_utils(router_test)
	
	router_env env;

	router_env_config cfg;
	router_wr_agent_config w_cfg[];
	router_rd_agent_config r_cfg[];

	int no_of_read_agent = 3;
	int no_of_write_agent = 1;

	bit has_wagent = 1;
	bit has_ragent = 1;






	extern function new(string name="router_test", uvm_component parent);
	extern function void config_router();
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);

endclass

/*****************************************************************************************/


function router_test::new(string name="router_test", uvm_component parent);
	super.new(name,parent);
endfunction

/****************************************************************************************/

function void router_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	cfg = router_env_config::type_id::create("cfg");
	
	if(has_wagent)
		cfg.w_cfg = new[no_of_write_agent];
		

	if(has_ragent)
		cfg.r_cfg = new[no_of_read_agent];

	config_router();
	uvm_config_db#(router_env_config) ::set(this,"*","router_env_config",cfg);
	env=router_env::type_id::create("env",this);
	
//	`uvm_info("ROUTER_XTN",$sformatf("inside the build phase"), UVM_MEDIUM);


endfunction



function void router_test::config_router();

	if(has_wagent)
		begin
		w_cfg = new[no_of_write_agent];

		foreach(w_cfg[i])
			begin
				w_cfg[i]=router_wr_agent_config::type_id::create($sformatf("w_cfg[%0d]",i));

				if(!uvm_config_db #(virtual router_if)::get(this,"","vif",w_cfg[i].vif))
					`uvm_fatal("VIF_CONFIG-WRITE","cannot get config data")
				w_cfg[i].is_active=UVM_ACTIVE;
				cfg.w_cfg[i] = w_cfg[i];
				$display("TEST ecgfw=%p",w_cfg[i].vif);
			end
		end



	if(has_ragent)
		begin
			r_cfg = new[no_of_read_agent];
			
			foreach(r_cfg[i])
				begin
					r_cfg[i] = router_rd_agent_config::type_id::create($sformatf("r_cfg[%0d]",i));
					
					if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("vif[%0d]",i),r_cfg[i].vif))
						`uvm_fatal("VIF_CONFIG-READ","cannot get config data")
				//	$display("TEST ecgfr_vif=%p",r_cfg[i].vif);

					r_cfg[i].is_active = UVM_ACTIVE;
					cfg.r_cfg[i]=r_cfg[i];
						$display("TEST ecgfr=%p",r_cfg[i].vif);

					
				end
		end

	cfg.has_wagent = has_wagent;
	cfg.has_ragent = has_ragent;
	cfg.no_of_read_agent = no_of_read_agent;
	cfg.no_of_write_agent = no_of_write_agent;

endfunction
			

function void router_test:: end_of_elaboration_phase(uvm_phase phase);
 	uvm_top.print_topology();
endfunction


/**************************************************************************************************************************************************/

class router_small_pkt_test extends router_test;
	`uvm_component_utils(router_small_pkt_test);

	router_small_pkt_vseqs router_seqh;
	bit[1:0]addr;

	extern function new(string name="router_small_pkt_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);	
	extern task run_phase(uvm_phase phase);

endclass

/*****************************************************************************************************************/

function router_small_pkt_test::new(string name="router_small_pkt_test",uvm_component parent);
	super.new(name,parent);
endfunction

/****************************************************************************************************************/

function void router_small_pkt_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

/*****************************************************************************************************************/

task router_small_pkt_test::run_phase(uvm_phase phase);
	//repeat(20)
    	//begin
      		//addr={$random}%3;
      		//uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
		addr = 2'b10;
	phase.raise_objection(this);
		//repeat(20)
			begin
				//addr = {$random}%3;
				uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
				
				router_seqh = router_small_pkt_vseqs::type_id::create("router_seqh");
				router_seqh.start(env.v_seqr);
			end
		phase.drop_objection(this);
//	end
endtask
/***********************************************************************************************************************************************************/

class router_medium_pkt_test extends router_test;
        `uvm_component_utils(router_medium_pkt_test);

        router_medium_pkt_vseqs router_seqh;
        bit[1:0]addr;

        extern function new(string name="router_medium_pkt_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

endclass

/*****************************************************************************************************************/

function router_medium_pkt_test::new(string name="router_medium_pkt_test",uvm_component parent);
        super.new(name,parent);
endfunction

/****************************************************************************************************************/

function void router_medium_pkt_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

/*****************************************************************************************************************/

task router_medium_pkt_test::run_phase(uvm_phase phase);
        phase.raise_objection(this);
                repeat(20)
                        begin
                                addr = {$random}%3;
                                uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);

                                router_seqh = router_medium_pkt_vseqs::type_id::create("router_seqh");
                                router_seqh.start(env.v_seqr);
                        end
        phase.drop_objection(this);

endtask
/***********************************************************************************************************************************************************/


class router_large_pkt_test extends router_test;
        `uvm_component_utils(router_large_pkt_test);

        router_large_pkt_vseqs router_seqh;
        bit[1:0]addr;

        extern function new(string name="router_large_pkt_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

endclass

/*****************************************************************************************************************/

function router_large_pkt_test::new(string name="router_large_pkt_test",uvm_component parent);
        super.new(name,parent);
endfunction

/****************************************************************************************************************/

function void router_large_pkt_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

/*****************************************************************************************************************/

task router_large_pkt_test::run_phase(uvm_phase phase);
        phase.raise_objection(this);
                repeat(20)
                        begin
                                addr = {$random}%3;
                                uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);

                                router_seqh = router_large_pkt_vseqs::type_id::create("router_seqh");
                                router_seqh.start(env.v_seqr);
                        end
        phase.drop_objection(this);

endtask
/***********************************************************************************************************************************************************/
