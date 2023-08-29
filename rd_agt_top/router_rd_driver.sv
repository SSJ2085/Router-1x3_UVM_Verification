class router_rd_driver extends uvm_driver#(read_xtn);

	`uvm_component_utils(router_rd_driver)

	virtual router_if.RDR_MP vif;
	router_rd_agent_config m_cfg;

	extern function new(string name="router_rd_driver",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(read_xtn xtn);
	extern function void report_phase(uvm_phase phase);

endclass

/**********************************************************************************************/

function router_rd_driver::new(string name="router_rd_driver",uvm_component parent);
        super.new(name,parent);
endfunction

/************************************************************************************************/

function void router_rd_driver::build_phase(uvm_phase phase);
        if(!uvm_config_db #(router_rd_agent_config)::get(this,"","router_rd_agent_config",m_cfg))
                `uvm_fatal("CONFIG","Cannot get() config");
        super.build_phase(phase);
endfunction

/*************************************************************************************************/

function void router_rd_driver::connect_phase(uvm_phase phase);
        //super.connect_phase(phase);
        vif = m_cfg.vif;
	$display("!!!!!!!!!!!!!!!!!!!!!!!!!!!%d",m_cfg.vif.v_out);	
endfunction

/***********************************************************************************************/

task router_rd_driver::run_phase(uvm_phase phase);
	
	forever
		begin

			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end

endtask

/***************************************************************************************************/

task router_rd_driver::send_to_dut(read_xtn xtn);
   begin
	@(vif.rdr_cb);   //

	@(vif.rdr_cb);

	$display("%s",get_full_name);
	$display("vld_out before wait = %d", vif.rdr_cb.v_out);
	
	wait(vif.rdr_cb.v_out) //
	$display("vld_out after wait = %d", vif.rdr_cb.v_out);
//	repeat(xtn.no_of_cycles) 
	@(vif.rdr_cb);
	vif.rdr_cb.read_enb<=1;
	
	$display("vld_out before =====1 = %d",vif.rdr_cb.v_out);

	wait(!vif.rdr_cb.v_out)	

	$display("vld_out after  =====1 = %d",vif.rdr_cb.v_out);
//	@(vif.rdr_cb);
	vif.rdr_cb.read_enb<=0;
	m_cfg.drv_data_count++;
	repeat(2)@(vif.rdr_cb);
	`uvm_info("ROUTER_RD_DRIVER",$sformatf("printing from Read Driver \n %s",xtn.sprint()),UVM_LOW)
  end
endtask

/*****************************************************************************************************/
function void router_rd_driver::report_phase(uvm_phase phase);

	`uvm_info(get_type_name(),$sformatf("Report: router read  driver sent %d transactions",m_cfg.drv_data_count),UVM_LOW)
endfunction

