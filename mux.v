// Description: The multiplexer module of the IF stage
             
module mux (
   output wire [31:0] y,     // Output of Multiplexer
   input wire  [31:0] a,     // Input 1 of Multiplexer
                      b,     // Input 0 of Multiplexer
   input wire  sel           // Select Input
   );
   
   assign	y = sel ? a : b;
endmodule // mux
