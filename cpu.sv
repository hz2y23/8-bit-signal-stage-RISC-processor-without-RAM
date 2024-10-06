
`include "alucodes.sv"
module cpu #( parameter n = 8) // data bus width
(input logic clk,
  input logic nReset, // master nReset
  input logic [n-1:0] SW,
  output logic[n-1:0] LED // need an output port, tentatively this will be the ALU output
);

// declarations of local signals that connect CPU modules
// ALU
logic [2:0] EXE_CMD; // ALU function
logic [n-1:0] ALURes; // ALU Result
logic [n-1:0] alub;

// registers
logic [n-1:0] Rdata1, Rdata2, Wdata, ImmG; // Register data
logic Reg_w; // register write control

// Program Counter 
parameter Psize = 8; // up to 256 instructions
logic PCincr, PCbranch; // program counter control
logic [Psize-1:0] PC, PC_IN;

// Program Memory
parameter Isize = n; // Isize - instruction width
logic [Isize-1:0] I; // I - instruction code

// Branch 
logic BLT, BEQ, branchEn; //branch flags, routed to controller

// MUX
logic ImSel; // immediate operand signal
logic [n-1:0] increase, increase_or_branch; // output from MUX

// module instantiations
PC #(.Psize(Psize))
		progCounter (.clk(clk),.nReset(nReset),
			.PC_IN(PC_IN),
			.PC(PC));

prog 	#(.Psize(Psize),.Isize(Isize))
		progMemory (.nReset(nReset),
			.address(PC),
			.I(I));

controller Control (.opcode(I[7:5]),
			.PCincr(PCincr),
            .PCbranch(PCbranch),
			.BEQ(BEQ),
			.BLT(BLT),
			.EXE_CMD(EXE_CMD),
			.ImSel(ImSel),
			.Reg_w(Reg_w),
			.branchEn(branchEn));

regs   #(.n(n))  
		gpr (.clk(clk),
			.nReset(nReset),
			.Reg_w(Reg_w),
			.Wdata(Wdata),
			.Raddr1(I[4:3]),    // reg %s1
			.Raddr2(I[1:0]), 	// reg %s2
			.Rdata1(Rdata1),
			.Rdata2(Rdata2));

alu    #(.n(n))  
		iu (.a(Rdata1),
			.b(alub),
			.EXE_CMD(EXE_CMD),
			.result(ALURes));

branch #(.n(n)) 
		br (.a(Rdata1),
			.b(Rdata2),
			.BEQ(BEQ),
			.BLT(BLT),
			.branchEn(branchEn));
			
ImmGen #(.n(n)) 
		ze0 (.Instruction(I),
			.ImmG(ImmG));
			
adder #(.WIDTH(Psize)) 
	adder_inst(.in1(PC), 
			  .in2(increase_or_branch), 
			  .out(PC_IN));
			  
// connect Register_output to LED		  
Register_output #(.Psize(Psize))
		Output (.clk(clk),.nReset(nReset),
			.RegIn(Rdata1),
			.ALURes(ALURes),
			.RegOut(LED));
			
// create MUX for immediate operand
assign alub = (ImSel ? ImmG : Rdata2);
assign Wdata = ((ALURes == 8'hFF) ? SW : ALURes);
assign increase_or_branch = (PCbranch ? ImmG : increase);
assign increase = (PCincr ? 8'b1 : 8'b0);

endmodule