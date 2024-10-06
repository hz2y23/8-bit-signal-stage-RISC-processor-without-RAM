
module branch #(parameter n =8) ( //8 bit processor
	input logic [n-1:0] a, b, // input operands
	input logic branchEn,
	output logic BEQ, BLT  // comparison result
);
	
// Calculate BEQ and BLT
always_comb
begin

if (a == b && branchEn)
	BEQ = 1'b1;
else
	BEQ = 1'b0;
end

always_comb
begin
if (a < b && branchEn)
	BLT = 1'b1;
else
	BLT = 1'b0;
end


	
endmodule