class router_vbase_seqs extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_utils(router_vbase_seqs)

	router_wr_seqencer wr_seqrh[];
	router_rd_seqencer rd_seqrh[];

	router_virtual_sequencer vseqrh;

	router_env_config m_cfg;

	extern function new(string name="router_vbase_seqs");
	extern task body();

endclass

/*************************************************************************************/

function router_vbase_seqs::new(string name="router_vbase_seqs");
	super.new(name);
endfunction

/************************************************************************************/

task router_vbase_seqs::body();

	if(!uvm_config_db #(router_env_config)::get(null,get_full_name(),"router_env_config",m_cfg))
		`uvm_fatal("CONFIG","Cannot get() the m_cfg from the uvm_config_db,did you set() it!")

	wr_seqrh = new[m_cfg.no_of_write_agent];
	rd_seqrh = new[m_cfg.no_of_read_agent];
	assert($cast(vseqrh,m_sequencer))
	else
		begin
			`uvm_error("BODY","error in $cast of virtual sequencer")
		end
	foreach(wr_seqrh[i])
		wr_seqrh[i] = vseqrh.wr_seqrh[i];
	foreach(rd_seqrh[i])
		rd_seqrh[i] = vseqrh.rd_seqrh[i];

endtask


/*************************************************************************************************************************/


class router_small_pkt_vseqs extends router_vbase_seqs;

	 
	`uvm_object_utils(router_small_pkt_vseqs)
	
	router_wxtns_small_pkt wrtns;
	router_rxtns_pkt rdtns;

	bit[1:0]addr;
	extern function new(string name="router_small_pkt_vseqs");
        extern task body();

endclass

/********************************************************************************************/

function router_small_pkt_vseqs::new(string name="router_small_pkt_vseqs");
        super.new(name);
endfunction
/*******************************************************************************************/

task router_small_pkt_vseqs::body();
	super.body();
	
	if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
		`uvm_fatal("CONFIG","Cannot get() the addr  from the uvm_config_db,did you set() it!")

	if(m_cfg.has_wagent)
		begin

			wrtns = router_wxtns_small_pkt::type_id::create("wrtns");
		end
	if(m_cfg.has_ragent)
		begin
			rdtns = router_rxtns_pkt::type_id::create("rdtns");
		end
	

	fork
		begin
			wrtns.start(wr_seqrh[0]);
		end
	

		begin
			if(addr ==2'b00)
				rdtns.start(rd_seqrh[0]);
			if(addr == 2'b01)
				rdtns.start(rd_seqrh[1]);
			if(addr ==2'b10)
				rdtns.start(rd_seqrh[2]);
		end
	join


endtask

/***************************************************************************************************************/


class router_medium_pkt_vseqs extends router_vbase_seqs;


        `uvm_object_utils(router_medium_pkt_vseqs)

        router_wxtns_medium_pkt wrtns;
	router_rxtns_pkt rdtns;

        bit[1:0]addr;
        extern function new(string name="router_medium_pkt_vseqs");
        extern task body();

endclass

/*************************************************************************************`*******/

function router_medium_pkt_vseqs::new(string name="router_medium_pkt_vseqs");
        super.new(name);
endfunction
/*******************************************************************************************/

task router_medium_pkt_vseqs::body();
        super.body();

        if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                `uvm_fatal("CONFIG","Cannot get() the addr  from the uvm_config_db,did you set() it!")
	if(m_cfg.has_wagent)
        	        begin
		
                	        wrtns = router_wxtns_medium_pkt::type_id::create("wrtns");
                	end

	if(m_cfg.has_ragent)
                begin
                        rdtns = router_rxtns_pkt::type_id::create("rdtns");
                end


        fork
               begin
                        wrtns.start(wr_seqrh[0]);
                end

		begin
                        if(addr ==2'b00)
                                rdtns.start(rd_seqrh[0]);
                        if(addr == 2'b01)
                                rdtns.start(rd_seqrh[1]);
                        if(addr ==2'b10)
                                rdtns.start(rd_seqrh[2]);
                end

        join

endtask


/***********************************************************************************************************************/

class router_large_pkt_vseqs extends router_vbase_seqs;


        `uvm_object_utils(router_large_pkt_vseqs)

        router_wxtns_large_pkt wrtns;
	router_rxtns_pkt rdtns;
        bit[1:0]addr;
        extern function new(string name="router_large_pkt_vseqs");
        extern task body();

endclass

/********************************************************************************************/

function router_large_pkt_vseqs::new(string name="router_large_pkt_vseqs");
        super.new(name);
endfunction
/*******************************************************************************************/

task router_large_pkt_vseqs::body();
        super.body();

        if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                `uvm_fatal("CONFIG","Cannot get() the addr  from the uvm_config_db,did you set() it!")
        if(m_cfg.has_wagent)
                        begin

                                wrtns = router_wxtns_large_pkt::type_id::create("wrtns");
                        end
			
	if(m_cfg.has_ragent)
                begin
                        rdtns = router_rxtns_pkt::type_id::create("rdtns");
                end


        fork
               begin
                        wrtns.start(wr_seqrh[0]);
                end

		begin
                        if(addr ==2'b00)
                                rdtns.start(rd_seqrh[0]);
                        if(addr == 2'b01)
                                rdtns.start(rd_seqrh[1]);
                        if(addr ==2'b10)
                                rdtns.start(rd_seqrh[2]);
                end


        join

endtask

/************************************************************************************************************/



