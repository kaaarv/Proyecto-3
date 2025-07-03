module adder #(parameter WIDTH=32) (
    input wire [WIDTH-1:0]  A, B,
    output wire [WIDTH-1:0]  Q
);

    assign Q = A + B;

endmodule
