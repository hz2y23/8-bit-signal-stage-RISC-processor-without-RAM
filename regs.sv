
module regs #(parameter n = 8) // n - data bus width
(input logic clk, nReset, Reg_w, // clk, nReset and write control
 input logic [n-1:0] Wdata,
 input logic [1:0] Raddr1, Raddr2,
 output logic [n-1:0] Rdata1, Rdata2);

 	// Declare 4 n-bit registers 
	logic [n-1:0] gpr [3:0];

	
	// write process, dest reg is Rd
	always_ff @ (posedge clk, negedge nReset)
	begin
		if (!nReset) begin
            for ( integer i = 0; i < 4; i = i + 1) begin
                gpr[i] <= 0;
            end
        end else if (Reg_w && Raddr1 != 0) begin  // Protect register 0 from being written to
            gpr[Raddr1] <= Wdata;
        end
	end

	// read process
	always_comb
	begin
	Rdata1 = gpr[Raddr1];
	Rdata2 = gpr[Raddr2];
	end	

endmodule