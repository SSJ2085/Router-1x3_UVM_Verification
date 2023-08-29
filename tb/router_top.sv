module top;

	import router_pkg::*;
	import uvm_pkg::*;


	bit clk;
	
	initial
		begin
			forever
				#10 clk = ~clk;
		end

	router_if in(clk);
	router_if in0(clk);
	router_if in1(clk);
	router_if in2(clk);
 
	router_top RTL(.clock(clk),.resetn(in.rst),.pkt_valid(in.pkt_valid),.read_enb_0(in0.read_enb),.read_enb_1(in1.read_enb),.read_enb_2(in2.read_enb),.data_in(in.data_in),.vld_out_0(in0.v_out),.vld_out_1(in1.v_out),.vld_out_2(in2.v_out),.err(in.error),.busy(in.busy),.data_out_0(in0.data_out),.data_out_1(in1.data_out),.data_out_2(in2.data_out));


	initial
	     begin
 		uvm_config_db#(virtual router_if)::set(null,"*","vif",in);
		uvm_config_db#(virtual router_if)::set(null,"*","vif[0]",in0);
		uvm_config_db#(virtual router_if)::set(null,"*","vif[1]",in1);
		uvm_config_db#(virtual router_if)::set(null,"*","vif[2]",in2);
	

		run_test();
	     end
endmodule
