`timescale 1ns/1ns
`include "Pipe_ID_EX.sv"

module pipe_id_ex_tb (
);

    parameter WIDTH = 32; 
   
    reg clk, rst;
    reg [3:0] ALUOP_IN;
    reg ALUSRC_IN, REGWRITE_IN, MEMTOREG_IN, MEMWRITE_IN, MEMREAD_IN;
    reg [4:0] ARS1_IN, ARS2_IN, ARD_IN;
    reg [WIDTH-1:0] RS1_IN, RS2_IN;
    reg [WIDTH-1:0] IMMEDIATE_IN;

    wire [3:0] ALUOP_OUT;
    wire ALUSRC_OUT, REGWRITE_OUT, MEMTOREG_OUT, MEMWRITE_OUT, MEMREAD_OUT;
    wire [4:0] ARS1_OUT, ARS2_OUT, ARD_OUT;
    wire [WIDTH-1:0] RS1_OUT, RS2_OUT;
    wire [WIDTH-1:0] IMMEDIATE_OUT;

pipe_id_ex dut(

    .clk(clk),
    .rst(rst),
    .ALUOP_IN(ALUOP_IN),
    .ALUSRC_IN(ALUSRC_IN),
    .REGWRITE_IN(REGWRITE_IN),
    .MEMTOREG_IN(MEMTOREG_IN),
    .MEMWRITE_IN(MEMWRITE_IN),
    .MEMREAD_IN(MEMREAD_IN),
    .ARS1_IN(ARS1_IN),
    .ARS2_IN(ARS2_IN),
    .ARD_IN(ARD_IN),
    .RS1_IN(RS1_IN),
    .RS2_IN(RS2_IN),
    .IMMEDIATE_IN(IMMEDIATE_IN),
    .ALUOP_OUT(ALUOP_OUT),
    .ALUSRC_OUT(ALUSRC_OUT),
    .REGWRITE_OUT(REGWRITE_OUT),
    .MEMTOREG_OUT(MEMTOREG_OUT),
    .MEMWRITE_OUT(MEMWRITE_OUT),
    .MEMREAD_OUT(MEMREAD_OUT),
    .ARS1_OUT(ARS1_OUT),
    .ARS2_OUT(ARS2_OUT),
    .ARD_OUT(ARD_OUT),
    .RS1_OUT(RS1_OUT),
    .RS2_OUT(RS2_OUT),
    .IMMEDIATE_OUT(IMMEDIATE_OUT)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end


initial begin

    $dumpfile("pipe_id_ex_tb.vcd");
    $dumpvars(0, pipe_id_ex_tb);

    clk = 0;
    rst = 1;
    ALUOP_IN = 4'b0000;
    ALUSRC_IN = 0;
    REGWRITE_IN = 0;
    MEMTOREG_IN = 0;
    MEMWRITE_IN = 0;
    MEMREAD_IN = 0;
    ARS1_IN = 5'b00000;
    ARS2_IN = 5'b00000;
    ARD_IN = 5'b00000;
    RS1_IN = 0;
    RS2_IN = 0;
    IMMEDIATE_IN = 0;

    rst = 0;
    #10;


    rst = 1;
    ALUOP_IN = 4'b1010;
    ALUSRC_IN = 1;
    REGWRITE_IN = 1;
    MEMTOREG_IN = 0;
    MEMWRITE_IN = 1;
    MEMREAD_IN = 0;
    ARS1_IN = 5'b00001;
    ARS2_IN = 5'b00010;
    ARD_IN = 5'b00011;
    RS1_IN = 32'hAAAAAAAA;
    RS2_IN = 32'h55555555;
    IMMEDIATE_IN = 32'h12345678;
    #10;
    // ALUOP_OUT = 1010
    // ALUSRC_OUT = 1
    // REGWRITE_OUT = 1
    // MEMTOREG_OUT = 0
    // MEMWRITE_OUT = 1
    // MEMREAD_OUT = 0
    // ARS1_OUT = 00001
    // ARS2_OUT = 00010
    // ARD_OUT = 00011
    // RS1_OUT = AAAAAAAA
    // RS2_OUT = 55555555
    // IMMEDIATE_OUT = 12345678

   
    ALUOP_IN = 4'b0101;
    ALUSRC_IN = 0;
    REGWRITE_IN = 0;
    MEMTOREG_IN = 1;
    MEMWRITE_IN = 0;
    MEMREAD_IN = 1;
    ARS1_IN = 5'b00100;
    ARS2_IN = 5'b00101;
    ARD_IN = 5'b00110;
    RS1_IN = 32'hFFFFFFFF;
    RS2_IN = 32'h00000000;
    IMMEDIATE_IN = 32'h87654321;
    #10;
    // ALUOP_OUT = 0101
    // ALUSRC_OUT = 0
    // REGWRITE_OUT = 0
    // MEMTOREG_OUT = 1
    // MEMWRITE_OUT = 0
    // MEMREAD_OUT = 1
    // ARS1_OUT = 00100
    // ARS2_OUT = 00101
    // ARD_OUT = 00110
    // RS1_OUT = FFFFFFFF
    // RS2_OUT = 00000000
    // IMMEDIATE_OUT = 87654321


    rst = 0;
    #10;
    // ALUOP_OUT = 0000
    // ALUSRC_OUT = 0
    // REGWRITE_OUT = 0
    // MEMTOREG_OUT = 0
    // MEMWRITE_OUT = 0
    // MEMREAD_OUT = 0
    // ARS1_OUT = 00000
    // ARS2_OUT = 00000
    // ARD_OUT = 00000
    // RS1_OUT = 00000000
    // RS2_OUT = 00000000
    // IMMEDIATE_OUT = 00000000


    $display("Test completado");
    $finish;

end

endmodule