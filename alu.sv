
`include "alucodes.sv"  
module alu #(parameter n = 8) (
   input logic [n-1:0] a, b, // ALU operands
   input logic [2:0] EXE_CMD, // ALU function code
   output logic [n-1:0] result // ALU result
);
logic overflow;

always_comb
begin
result = 0;
overflow = 0;
  case(EXE_CMD)
	`NOP: result = {n{1'b0}};
  	`RSLL: result = a << b;
	`RADD: begin {overflow, result} = a + b; 
				if (overflow) 
					result = 8'hFF; 
			end
	`RSUB: result = a - b;
	`RSRL: result = a >> b;
	default: result = {n{1'b0}};
   endcase
 end 

endmodule 

