

module Register_output #(
    parameter integer Psize = 8  // Parameter for the bit-width of the register
) (
    input logic clk,
    input logic nReset,
    input logic [Psize-1:0] RegIn,
	input logic [Psize-1:0] ALURes,
    output logic [Psize-1:0] RegOut
);
    always_ff @(posedge clk or negedge nReset) begin
        if (!nReset)
            RegOut <= '0;
        else if (ALURes == 8'hFF)
            RegOut <= RegIn;  // Write new value if ALURes == 8'hFF
    end

endmodule