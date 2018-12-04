// Description     : The instruction memory module of the IF stage.          

module memory (
   output reg [31:0] data,       // Output of Instruction Memory
   input wire [31:0] addr        // Input of Instruction Memory
   );

// Register Declarations
   reg [31:0] MEM[0:127];  // 128 words of 32-bit memory

	integer i;

// Initialize Registers
   initial begin	
		$readmemb("etc/RISC.txt",MEM);
   end
   
   always @(addr) begin
		data <= MEM[addr];
	end
endmodule // memory
