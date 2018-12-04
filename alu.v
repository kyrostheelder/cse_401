`timescale 1ns / 1ps
/* alu.v  */
module alu(
    input	wire	[31:0]	a,
    input	wire	[31:0]	b,
    input	wire	[2:0]   control,
    output	reg	    [31:0]	result,
    output	wire			zero
    
    );

	parameter	ALUadd	= 3'b010;
	parameter	ALUsub	= 3'b110;	  
	parameter   ALUand	= 3'b000;      
	parameter   ALUor	= 3'b001;	
	parameter   ALUslt	= 3'b111;
					
					
	
	// Handles negative inputs
	wire sign_mismatch;
	assign sign_mismatch = a[31] ^ a[32];
	
	initial
		result <= 0;
	
	always@*
		case(control)
			ALUadd:			result = a + b;
			ALUsub:			result = a - b;
			ALUand:			result = a && b;
			ALUor:			result = a || b;
			ALUslt:			result = a < b	? 1 - sign_mismatch : 0 + sign_mismatch;			
			default:			result = 32'bX;	// control = ALUx | *
		endcase
		
	   
	   assign zero = (result==0) ? 1'b1 : 1'b0;
		
endmodule

 
