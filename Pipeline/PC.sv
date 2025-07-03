module pc #(parameter WIDTH=32)(
    input wire clk, rst,
    input wire STALL,
    input wire PCWRITE,
    input wire [WIDTH-1:0]  IN,
    output reg [WIDTH-1:0] OUT
);

always_ff @(posedge clk) begin

if(!rst) OUT<={WIDTH{1'b0}};
else begin
if(!STALL) OUT<=IN;
end

end
    
endmodule
