module pipe_ex_mem #(parameter WIDTH=32) (
    input wire clk, rst,

    input wire MEMWRITE_IN, MEMTOREG_IN, REGWRITE_IN,
    input wire [WIDTH-1:0] RESULTOP_IN, WRDATA_IN,
    input wire [4:0] ARD_IN,

    output reg MEMWRITE_OUT, MEMTOREG_OUT, REGWRITE_OUT,
    output reg [WIDTH-1:0] RESULTOP_OUT, WRDATA_OUT,
    output reg [4:0] ARD_OUT
);

always_ff @(posedge clk) begin
    if(!rst) begin
        {MEMWRITE_OUT, MEMTOREG_OUT, REGWRITE_OUT}<={1'b0, 1'b0, 1'b0};
        {RESULTOP_OUT, WRDATA_OUT}<={{WIDTH{1'b0}},{WIDTH{1'b0}}};
        ARD_OUT<=5'b00000;
    end
    else begin
        {MEMWRITE_OUT, MEMTOREG_OUT, REGWRITE_OUT}<={MEMWRITE_IN, MEMTOREG_IN, REGWRITE_IN};
        {RESULTOP_OUT, WRDATA_OUT}<={RESULTOP_IN, WRDATA_IN};
        ARD_OUT<=ARD_IN;
    end
end
    
endmodule
