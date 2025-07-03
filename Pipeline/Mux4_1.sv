module mux41 #(parameter WIDTH=32) (
  input wire [1:0] SEL,
  input wire [WIDTH-1:0] IN0, IN1, IN2, IN3,
  output reg [WIDTH-1:0] OUT
);

always_comb begin
case (SEL)
    2'b00: OUT=IN0;
    2'b01: OUT=IN1;
    2'b10: OUT=IN2;
    2'b11: OUT=IN3;
endcase
end

endmodule
