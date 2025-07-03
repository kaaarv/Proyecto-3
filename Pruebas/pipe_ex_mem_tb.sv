`timescale 1ns/1ns
`include "Pipe_EX_MEM.sv"

module pipe_ex_mem_tb (
);

    parameter WIDTH = 32;

    reg clk, rst;
    reg MEMWRITE_IN, MEMTOREG_IN, REGWRITE_IN;
    reg [WIDTH-1:0] RESULTOP_IN, WRDATA_IN;
    reg [4:0] ARD_IN;

    wire MEMWRITE_OUT, MEMTOREG_OUT, REGWRITE_OUT;
    wire [WIDTH-1:0] RESULTOP_OUT, WRDATA_OUT;
    wire [4:0] ARD_OUT;


pipe_ex_mem dut (

    .clk(clk),
    .rst(rst),
    .MEMWRITE_IN(MEMWRITE_IN),
    .MEMTOREG_IN(MEMTOREG_IN),
    .REGWRITE_IN(REGWRITE_IN),
    .RESULTOP_IN(RESULTOP_IN),
    .WRDATA_IN(WRDATA_IN),
    .ARD_IN(ARD_IN),
    .MEMWRITE_OUT(MEMWRITE_OUT),
    .MEMTOREG_OUT(MEMTOREG_OUT),
    .REGWRITE_OUT(REGWRITE_OUT),
    .RESULTOP_OUT(RESULTOP_OUT),
    .WRDATA_OUT(WRDATA_OUT),
    .ARD_OUT(ARD_OUT)
);


initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
    


initial begin

    $dumpfile("pipe_ex_mem_tb.vcd");
    $dumpvars(0, pipe_ex_mem_tb);

    rst = 1;
    MEMWRITE_IN = 0;
    MEMTOREG_IN = 0;
    REGWRITE_IN = 0;
    RESULTOP_IN = 0;
    WRDATA_IN = 0;
    ARD_IN = 0;

    rst = 0;
    #10;

    rst = 1; 
    MEMWRITE_IN = 1;
    MEMTOREG_IN = 1;
    REGWRITE_IN = 1;
    RESULTOP_IN = 32'hA5A5A5A5;
    WRDATA_IN = 32'h55555555;
    ARD_IN = 5'b10101;
    #10;
    //MEMWRITE_OUT = 1
    //MEMTOREG_OUT = 1
    //REGWRITE_OUT = 1
    //RESULTOP_OUT = A5A5A5A5
    //WRDATA_OUT = 55555555
    //ARD_OUT = 10101;


    MEMWRITE_IN = 0;
    MEMTOREG_IN = 1;
    REGWRITE_IN = 0;
    RESULTOP_IN = 32'h12345678;
    WRDATA_IN = 32'h87654321;
    ARD_IN = 5'b01010;
    #10;
    //MEMWRITE_OUT = 0
    //MEMTOREG_OUT = 1
    //REGWRITE_OUT = 0
    //RESULTOP_OUT = 12345678
    //WRDATA_OUT = 87654321
    //ARD_OUT = 01010


    rst = 0;
    #10;
    //MEMWRITE_OUT = 0
    //MEMTOREG_OUT = 0
    //REGWRITE_OUT = 0
    //RESULTOP_OUT = 00000000
    //WRDATA_OUT = 00000000
    //ARD_OUT = 00000


    $display("Test completado");
    $finish;


end

endmodule