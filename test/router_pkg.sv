package router_pkg;

import uvm_pkg::*;
	`include "uvm_macros.svh"
//	`include "router_if.sv"
	`include "tb_defs.sv"
	`include "write_xtn.sv"
	`include "router_wr_agent_config.sv"
	`include "router_rd_agent_config.sv"
	`include "router_env_config.sv"
	`include "router_wr_driver.sv"
	`include "router_wr_monitor.sv"
	`include "router_wr_seqencer.sv"
	`include "router_wr_agent.sv"
	`include "router_wr_agt_top.sv"
	`include "router_wr_seqs.sv"
	
	`include "read_xtn.sv"
	`include "router_rd_driver.sv"
	`include "router_rd_monitor.sv"
	`include "router_rd_seqencer.sv"
	`include "router_rd_agent.sv"
	`include "router_rd_agt_top.sv"
	`include "router_rd_seqs.sv"

	`include "router_virtual_sequencer.sv"
	`include "router_virtual_seqs.sv"
	`include "router_scoreboard.sv"

	`include "router_env.sv"
	
	`include "router_vtest_lib.sv"

	
endpackage
