module adder #(
    parameter integer WIDTH = 8  // bit-width
) (
    input logic [WIDTH-1:0] in1, in2,  // Inputs
    output logic [WIDTH-1:0] out      // Output
);

    // Perform addition and assign to output
    assign out = in1 + in2;

endmodule
