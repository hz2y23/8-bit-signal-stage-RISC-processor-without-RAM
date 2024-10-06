// sample 8-bit single stage processor
//	int A = 0;
//	int B = 1;
//	while (A < x) {
//	A = A * 2 + B;  // Update A based on B
//	B = B << 1;  // Left shift B by 1
//	}

module prog #(parameter Psize = 8, Isize = 8) // psize - address width, Isize - instruction width
(input logic nReset, 
input logic [Psize-1:0] address,
output logic [Isize-1:0] I); // I - instruction code

// program memory declaration, note: 1<<n is same as 2^n
logic [Isize-1:0] instMem[ (1<<Psize)-1:0];

// get memory contents if nReset
always_comb
    if (!nReset) begin
	instMem[0] = 8'b101_10_111;		//ADDI %2, 3'b111;						R2 = x
	instMem[1] = 8'b101_11_001;		//ADDI %3, 1;							R3(B) = 1
	//LOOP_START:
	instMem[2] = 8'b100_10_1_01;	//BLT %2, %1(5); 						if R2 < R1, PC += 5(branch end loop)
	instMem[3] = 8'b001_01_001;		//SLLI %1, 1;							R1 = R1 << 1
	instMem[4] = 8'b000_01_011;		//ADD %1, %3;	 						R1 = R1 + R3
	instMem[5] = 8'b001_11_001;		//SLLI %3, 1; 							R3 = R3 << 1
	instMem[6] = 8'b010_11100;		//J -4; 		 						PC += -4 (branch BLT)
	//END_LOOP:
	instMem[7] = 8'b101_11_111;		//ADDI %3, 3'b111;						LED = R3
	end
  
// program memory read 
  assign I = instMem[address];
  
endmodule