`timescale 1ns / 1ps
/* data_memory.v */
module data_memory (
	output	reg   [31:0]	read_data,		// Output of Memory Address Contents
   input		wire	[31:0]	addr,				// Memory Address
   input		wire	[31:0]	write_data,		// Memory Address Contents
   input		wire				memwrite, memread
	);

	// Register Declaration
   reg [31:0] DMEM[0:255];  // 256 words of 32-bit memory

   integer i;
	
	initial begin
		read_data <= 0;
		
		//  Initialize DMEM[0-5] from data.txt
		$readmemb("etc/data.txt",DMEM);
		
   end
   
   always@(addr)begin
		if ((memread == 1) && (memwrite == 0))
            // Read data
				read_data <= DMEM[addr];
		if ((memwrite == 1) && (memwrite == 0))
				// Write data
            DMEM[addr] <= write_data;
	end
endmodule // data_memory
