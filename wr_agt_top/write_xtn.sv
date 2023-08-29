class write_xtn extends uvm_sequence_item;


	`uvm_object_utils(write_xtn)

	rand bit[7:0]header;
	rand bit[7:0]payload_data[];
	bit [7:0] parity;

	constraint c1{header[1:0]!=3;}
	constraint c2{payload_data.size==header[7:2];}
	constraint c3{payload_data.size !=0;}

	extern function new(string name = "write_xtn");
	extern function void do_print(uvm_printer printer);
	extern function void post_randomize();

endclass

/**************************************************************************************************/

function write_xtn::new(string name = "write_xtn");
	super.new(name);
endfunction

/*************************************************************************************************/
function void  write_xtn::do_print (uvm_printer printer);
	super.do_print(printer);

   	//                   srting name   	bitstream value     size    radix for printing
    	printer.print_field( "header", 		this.header, 	    8,		 UVM_BIN		);
	foreach(payload_data[i])
   	 	printer.print_field( $sformatf("payload_data[%0d]",i), this.payload_data[i], 	    8,		 UVM_DEC		);
    	printer.print_field( "parity", 		this.parity, 	    8,		 UVM_DEC		);
endfunction

/**************************************************************************************************/

function void write_xtn::post_randomize();
	parity= 0^header;
	foreach(payload_data[i])
		begin
		parity=payload_data[i]^parity;
		end
endfunction	
	
