module branch_comp #(parameter WIDTH=32) (
    input wire [WIDTH-1:0] IN1, IN2,
    output reg OUT
);

always_comb begin 
    OUT = (IN1 == IN2) ? 1'b1 : 1'b0;
end
    
endmodule