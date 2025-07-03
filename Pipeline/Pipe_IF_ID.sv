module pipe_if_id #(parameter WIDTH=32) (
    input wire clk, rst, FLUSH, STALL,
    
    input wire [WIDTH-1:0] PC_IN,
    input wire [WIDTH-1:0] INSTRUCTION_IN,
    
    output reg [WIDTH-1:0] PC_OUT,
    output reg [WIDTH-1:0] INSTRUCTION_OUT
);

always_ff @(posedge clk) begin 
    if(!rst || FLUSH) begin
        PC_OUT<={WIDTH{1'b0}};
        INSTRUCTION_OUT<={WIDTH{1'b0}};
    end
    else begin
        if(!STALL) begin
            PC_OUT<=PC_IN;
            INSTRUCTION_OUT<=INSTRUCTION_IN;
        end
    end
end
    
endmodule
