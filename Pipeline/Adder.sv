<<<<<<< HEAD
module adder #(parameter WIDTH=32) (
    input wire [WIDTH-1:0]  A, B,
    output wire [WIDTH-1:0]  Q
);

    assign Q = A + B;
=======
module Adder(
    input logic [63:0] a,
    input logic [63:0] b,
    output logic [63:0] out
);

    assign out = a + b;
>>>>>>> 10c52be48bd9d1a4a9bd006f84f8887bd5bb0583

endmodule
