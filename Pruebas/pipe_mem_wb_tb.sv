`timescale 1ns/1ns
`include "Pipe_MEM_WB.sv"

module pipe_mem_wb_tb (
);
    parameter WIDTH=32;
    
    reg clk, rst;
    reg MEMTOREG_IN, REGWRITE_IN;
    reg [WIDTH-1:0] MEMDATA_IN, RESULTOP_IN;
    reg [4:0] ARD_IN;

    wire MEMTOREG_OUT, REGWRITE_OUT;
    wire [WIDTH-1:0] MEMDATA_OUT, RESULTOP_OUT;
    wire [4:0] ARD_OUT;

pipe_mem_wb dut(

    .clk(clk),
    .rst(rst),
    .MEMTOREG_IN(MEMTOREG_IN),
    .REGWRITE_IN(REGWRITE_IN),
    .MEMDATA_IN(MEMDATA_IN),
    .RESULTOP_IN(RESULTOP_IN),
    .ARD_IN(ARD_IN),
    .MEMTOREG_OUT(MEMTOREG_OUT),
    .REGWRITE_OUT(REGWRITE_OUT),
    .MEMDATA_OUT(MEMDATA_OUT),
    .RESULTOP_OUT(RESULTOP_OUT),
    .ARD_OUT(ARD_OUT)
);


initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    $dumpfile("pipe_mem_wb_tb.vcd");
    $dumpvars(0, pipe_mem_wb_tb);

    rst = 1;
    MEMTOREG_IN = 0;
    REGWRITE_IN = 0;
    MEMDATA_IN = 0;
    RESULTOP_IN = 0;
    ARD_IN = 0;


    rst = 0;
    #10;
    
    
    rst = 1;
    MEMTOREG_IN = 1;
    REGWRITE_IN = 1;
    MEMDATA_IN = 32'hDEADBEEF;
    RESULTOP_IN = 32'h12345678;
    ARD_IN = 5'b10101;
    #10;
    // MEMTOREG_OUT = 1
    // REGWRITE_OUT = 1
    // MEMDATA_OUT = DEADBEEF
    // RESULTOP_OUT = 12345678
    // ARD_OUT = 10101


    MEMTOREG_IN = 0;
    REGWRITE_IN = 0;
    MEMDATA_IN = 32'hFFFFFFFF;
    RESULTOP_IN = 32'h87654321;
    ARD_IN = 5'b01110;
    #10;
    // MEMTOREG_OUT = 0
    // REGWRITE_OUT = 0
    // MEMDATA_OUT = FFFFFFFF
    // RESULTOP_OUT = 87654321
    // ARD_OUT = 01110


    rst = 0;
    #10;
    // MEMTOREG_OUT = 0
    // REGWRITE_OUT = 0
    // MEMDATA_OUT = 00000000
    // RESULTOP_OUT = 00000000
    // ARD_OUT = 00000



    $display("Test completado");
    $finish;

end


endmodule