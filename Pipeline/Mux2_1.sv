module mux21 #(parameter WIDTH=32) (
    input wire SEL,
    input wire [WIDTH-1:0] IN0,IN1,
    output reg [WIDTH-1:0] OUT
);

always_comb OUT=SEL?IN1:IN0;
    
endmodule