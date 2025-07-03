module pipe_mem_wb #(parameter WIDTH=32) (
    input clk, rst,

    input wire MEMTOREG_IN, REGWRITE_IN,
    input wire [WIDTH-1:0] MEMDATA_IN, RESULTOP_IN,
    input wire [4:0] ARD_IN,

    output reg MEMTOREG_OUT, REGWRITE_OUT,
    output reg [WIDTH-1:0] MEMDATA_OUT, RESULTOP_OUT,
    output reg [4:0] ARD_OUT
);

always_ff @(posedge clk) begin
    if(!rst) begin
        {MEMTOREG_OUT, REGWRITE_OUT}<={1'b0, 1'b0};
        {MEMDATA_OUT, RESULTOP_OUT}<={{WIDTH{1'b0}}, {WIDTH{1'b0}}};
        ARD_OUT<=1'b0;
    end 
    else begin
        {MEMTOREG_OUT, REGWRITE_OUT}<={MEMTOREG_IN, REGWRITE_IN};
        {MEMDATA_OUT, RESULTOP_OUT}<={MEMDATA_IN, RESULTOP_IN};
        ARD_OUT<=ARD_IN;
    end
end
    
endmodule
