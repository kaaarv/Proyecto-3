`timescale 1ns/1ns
`include "Pipe_IF_ID.sv"

module pipe_if_id_tb (
);

    parameter WIDTH = 32;

    reg clk, rst, FLUSH, STALL;
    reg [WIDTH-1:0] PC_IN;
    reg [WIDTH-1:0] INSTRUCTION_IN;

    wire [WIDTH-1:0] PC_OUT;
    wire [WIDTH-1:0] INSTRUCTION_OUT;

pipe_if_id dut (

    .clk(clk),
    .rst(rst),
    .FLUSH(FLUSH),
    .STALL(STALL),
    .PC_IN(PC_IN),
    .INSTRUCTION_IN(INSTRUCTION_IN),
    .PC_OUT(PC_OUT),
    .INSTRUCTION_OUT(INSTRUCTION_OUT)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end


initial begin

    $dumpfile("pipe_if_id_tb.vcd");
    $dumpvars(0, pipe_if_id_tb);

    rst = 1;
    FLUSH = 0;
    STALL = 0;
    PC_IN = 0;
    INSTRUCTION_IN = 0;

    rst = 0;
    #10;

    rst = 1;
    PC_IN = 32'h12345678;
    INSTRUCTION_IN = 32'hAAAAAAAA;
    #10;
    // PC_OUT = 12345678
    // INSTRUCTION_OUT = AAAAAAAA



    //STALL
    STALL = 1;
    PC_IN = 32'h87654321;
    INSTRUCTION_IN = 32'hBBBBBBBB;
    #10;
    // PC_OUT = 12345678
    // INSTRUCTION_OUT = AAAAAAAA


    STALL = 0;
    #10;
    // PC_OUT = 87654321
    // INSTRUCTION_OUT = BBBBBBBB



    //FLUSH
    FLUSH = 1;
    #10;
    // PC_OUT = 00000000
    // INSTRUCTION_OUT = 00000000


    FLUSH = 0;
    PC_IN = 32'hFFFFFFFF;
    INSTRUCTION_IN = 32'h11111111;
    #10;
    // PC_OUT = FFFFFFFF
    // INSTRUCTION_OUT = 11111111


    //RESET
    rst = 0;
    #10;
    // PC_OUT = 00000000
    // INSTRUCTION_OUT = 00000000



    $display("Test completado");
    $finish;

end

endmodule