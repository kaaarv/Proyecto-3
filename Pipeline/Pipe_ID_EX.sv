module pipe_id_ex #(parameter WIDTH=32) (
    input wire clk, rst,
    
    input wire [3:0] ALUOP_IN,
    input wire ALUSRC_IN, REGWRITE_IN, MEMTOREG_IN, MEMWRITE_IN, MEMREAD_IN,
    input wire [4:0] ARS1_IN, ARS2_IN, ARD_IN,
    input wire [WIDTH-1:0] RS1_IN, RS2_IN,
    input wire [WIDTH-1:0] IMMEDIATE_IN,

    output reg [3:0] ALUOP_OUT,
    output reg ALUSRC_OUT, REGWRITE_OUT, MEMTOREG_OUT, MEMWRITE_OUT, MEMREAD_OUT,
    output reg [4:0] ARS1_OUT, ARS2_OUT, ARD_OUT,
    output reg [WIDTH-1:0] RS1_OUT, RS2_OUT,
    output reg [WIDTH-1:0] IMMEDIATE_OUT
);
always_ff @(posedge clk) begin
    if(!rst) begin
        {ALUOP_OUT, ALUSRC_OUT, REGWRITE_OUT, MEMTOREG_OUT, MEMWRITE_OUT, MEMREAD_OUT}<={4'b0000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
        {ARS1_OUT, ARS2_OUT, ARD_OUT}<={5'b00000, 5'b00000, 5'b00000};
        {RS1_OUT, RS2_OUT}<={{WIDTH{1'b0}},{WIDTH{1'b0}}};
        IMMEDIATE_OUT<={WIDTH{1'b0}};
    end
    else begin
        {ALUOP_OUT, ALUSRC_OUT, REGWRITE_OUT, MEMTOREG_OUT, MEMWRITE_OUT, MEMREAD_OUT}<={ALUOP_IN, ALUSRC_IN, REGWRITE_IN, MEMTOREG_IN, MEMWRITE_IN, MEMREAD_IN};
        {ARS1_OUT, ARS2_OUT, ARD_OUT}<={ARS1_IN, ARS2_IN, ARD_IN};
        {RS1_OUT, RS2_OUT}<={RS1_IN,RS2_IN};
        IMMEDIATE_OUT<=IMMEDIATE_IN;
    end
end
    
endmodule