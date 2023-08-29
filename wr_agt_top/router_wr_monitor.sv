class router_wr_monitor extends uvm_monitor;
	`uvm_component_utils(router_wr_monitor)

	virtual router_if.WMON_MP vif;
	router_wr_agent_config m_cfg;
	write_xtn mon_data;
	extern function new(string name = "router_wr_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();	
	extern function void report_phase(uvm_phase phase);
endclass

/************************************************************************************************/

function router_wr_monitor::new(string name = "router_wr_monitor",uvm_component parent);
	super.new(name,parent);
endfunction

/*************************************************************************************************/

function void router_wr_monitor::build_phase(uvm_phase phase);
	if(!uvm_config_db #(router_wr_agent_config)::get(this,"","router_wr_agent_config",m_cfg))
		`uvm_fatal("CONFIG","connot get() the config");
	super.build_phase(phase);
endfunction

/**************************************************************************************************/

function void router_wr_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif = m_cfg.vif;
endfunction

/*************************************************************************************************/
 
task router_wr_monitor::run_phase(uvm_phase phase);
	forever
		collect_data();
endtask

/****************************************************************************************************/

task router_wr_monitor::collect_data();
    begin
	mon_data = write_xtn::type_id::create("mon_data");	
//	@(vif.wrmon_cb);
	@(vif.wrmon_cb);
	//wait(vif.wrmon_cb.pkt_valid && !vif.wrmon_cb.busy)
		while(~vif.wrmon_cb.pkt_valid)
		@(vif.wrmon_cb)
		
		while(vif.wrmon_cb.busy)
		@(vif.wrmon_cb);
	//wait(vif.wrmon_cb.pkt_valid)
       	//@(vif.wrmon_cb);
		mon_data.header = vif.wrmon_cb.data_in;
		mon_data.payload_data = new[mon_data.header[7:2]];
	@(vif.wrmon_cb);
//	@(vif.wrmon_cb);
		foreach(mon_data.payload_data[i])
			begin
	//		wait(~vif.wrmon_cb.busy)
				while(vif.wrmon_cb.busy)
				@(vif.wrmon_cb);
			//@(vif.wrmon_cb);
					mon_data.payload_data[i] = vif.wrmon_cb.data_in;
//			@(vif.wrmon_cb);
				@(vif.wrmon_cb);
		end
//	wait(!vif.wrmon_cb.pkt_valid && !vif.wrmon_cb.busy)
	while(vif.wrmon_cb.busy)	
	@(vif.wrmon_cb);	
	
		mon_data.parity = vif.wrmon_cb.data_in;
	//	repeat(2)@(vif.wrmon_cb);
//	mon_data.busy = vif.wrmon_cb.busy;
//	@(vif.wrmon_cb);
			//mon_data.err = vif.wmon_cb.error;
			
			
	m_cfg.mon_data_count++;
	`uvm_info("ROUTER_WR_MONITOR",$sformatf("printing from monitor \n %s",mon_data.sprint()),UVM_LOW)
    end
endtask

/**************************************************************************************************/

function void router_wr_monitor::report_phase(uvm_phase phase);
	//super.report_phase(phase);
	`uvm_info(get_type_name(),$sformatf("Report: router write monitor sent %d transactions",m_cfg.mon_data_count),UVM_LOW)
endfunction

/*********************************************************************************************************/



	
			
