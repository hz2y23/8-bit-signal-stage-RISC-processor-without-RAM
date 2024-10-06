`include "opcodes.sv"

module ImmGen #(
    parameter integer n = 8
) (
    input logic [n-1:0] Instruction,
    output logic [n-1:0] ImmG
);

    always_comb
    case(Instruction[7:5])
        `ADDI: ImmG = {{5{Instruction[2]}}, Instruction[2:0]}; //sign extend
		`SLLI: ImmG = {5'b0, Instruction[2:0]}; //zero extend
		`BLT:  ImmG = {5'b0, Instruction[2:0]}; //zero extend
		`BEQ:  ImmG = {5'b0, Instruction[2:0]}; //zero extend
		`J:    ImmG = {{3{Instruction[4]}}, Instruction[4:0]}; //sign extend
        default: ImmG = {8'b0};
    endcase
endmodule
