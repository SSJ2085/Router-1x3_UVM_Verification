class router_rd_monitor extends uvm_monitor;
        `uvm_component_utils(router_rd_monitor)

        virtual router_if.RDMON_MP vif;
        router_rd_agent_config m_cfg;
	read_xtn mon_data;

        extern function new(string name = "router_rd_monitor",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();	
	extern function void report_phase(uvm_phase phase);
endclass

/************************************************************************************************/

function router_rd_monitor::new(string name = "router_rd_monitor",uvm_component parent);
        super.new(name,parent);
endfunction

/*************************************************************************************************/

function void  router_rd_monitor::build_phase(uvm_phase phase);
        if(!uvm_config_db #(router_rd_agent_config)::get(this,"","router_rd_agent_config",m_cfg))
                `uvm_fatal("CONFIG","connot get() the config");
        super.build_phase(phase);
endfunction

/**************************************************************************************************/

function void router_rd_monitor::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif = m_cfg.vif;
endfunction

/*************************************************************************************************/

task router_rd_monitor::run_phase(uvm_phase phase);
	forever
		begin
			collect_data();
		end
endtask

/**************************************************************************************************/

task router_rd_monitor::collect_data();
   begin
	mon_data=read_xtn::type_id::create("mon_data");
	@(vif.rdmon_cb);
	while(!vif.rdmon_cb.read_enb)
	@(vif.rdmon_cb);

	@(vif.rdmon_cb);	
//	mon_data=read_xtn::type_id::create("mon_data");
//	@(vif.rdmon_cb)
//	wait(vif.rdmon_cb.read_enb)
//	@(vif.rdmon_cb);
	mon_data.header=vif.rdmon_cb.data_out;
	mon_data.payload_data=new[mon_data.header[7:2]];
//	@(vif.rdmon_cb);
	@(vif.rdmon_cb);
	foreach(mon_data.payload_data[i])
		begin
			while(!vif.rdmon_cb.read_enb)
			@(vif.rdmon_cb);
			mon_data.payload_data[i]= vif.rdmon_cb.data_out;
//			@(vif.rdmon_cb);
			@(vif.rdmon_cb);
		end
	mon_data.parity=vif.rdmon_cb.data_out;
	@(vif.rdmon_cb);
//	@(vif.rdmon_cb);
	`uvm_info("ROUTER_RD_MONITOR",$sformatf("printing from read monitor \n %s",mon_data.sprint()),UVM_LOW)
	m_cfg.mon_data_count++;
   end
endtask

/********************************************************************************************************/
function void router_rd_monitor::report_phase(uvm_phase phase);
	//super.report_phase(phase);
	`uvm_info(get_type_name(),$sformatf("Report: router write monitor sent %d transactions",m_cfg.mon_data_count),UVM_LOW)
endfunction

			
