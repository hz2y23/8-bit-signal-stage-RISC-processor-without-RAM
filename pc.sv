
module PC #(
    parameter integer Psize = 8  // Parameter for the bit-width of the PC
) (
    input logic clk,
    input logic nReset,
    input logic [Psize-1:0] PC_IN,
    output logic [Psize-1:0] PC
);
    always_ff @(posedge clk or negedge nReset) begin
        if (!nReset)
            PC <= '0;
        else
            PC <= PC_IN;
    end

endmodule