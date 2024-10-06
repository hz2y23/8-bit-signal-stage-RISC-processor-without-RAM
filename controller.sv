
`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module controller
( input logic [2:0] opcode, // top 3 bits of instruction
input logic  BLT, BEQ,
// output signals
//    PC control
output logic PCbranch, PCincr,
//    ALU control
output logic [2:0] EXE_CMD, 
// imm mux control
output logic ImSel,
// register file control
output logic Reg_w,
//branch control
output logic branchEn
  );

// instruction decoder
always_comb 
begin
	PCincr = 1'b1; ImSel = 1'b0; Reg_w = 1'b0; EXE_CMD = `NOP; PCbranch = 1'b0; branchEn = 1'b0;
   case(opcode)
		`ADD:	begin	Reg_w = 1'b1;		EXE_CMD = `RADD; end
		`SUB: 	begin	Reg_w = 1'b1;		EXE_CMD = `RSUB; end
		`SRL:	begin	Reg_w = 1'b1;		EXE_CMD = `RSRL; end
		`ADDI: 	begin 	Reg_w = 1'b1;		EXE_CMD = `RADD;	ImSel = 1'b1; end		
		`SLLI:  begin	Reg_w = 1'b1;		EXE_CMD = `RSLL;	ImSel = 1'b1;	end
		`J:		begin	PCbranch = 1'b1; end
		`BLT:	begin	branchEn = 1'b1;	if (BLT) PCbranch = 1'b1; end
		`BEQ:	begin	branchEn = 1'b1;	if (BEQ) PCbranch = 1'b1; end
		default: begin	PCincr = 1'b1; ImSel = 1'b0; Reg_w = 1'b0; EXE_CMD = `NOP; PCbranch = 1'b0; branchEn = 1'b0; end
		
  endcase
 end
endmodule