`timescale 1ns/1ns
`include "Hazard_Unit.sv"

module hazard_unit_tb (
);

    reg MEMREAD_ID_EX;
    reg [4:0] ARS1_IF_ID, ARS2_IF_ID, ARD_ID_EX;
    wire STALL, MUX_SEL;

H hazard_unit_tb (

    .MEMREAD_ID_EX(MEMREAD_ID_EX),
    .ARS1_IF_ID(ARS1_IF_ID),
    .ARS2_IF_ID(ARS2_IF_ID),
    .ARD_ID_EX(ARD_ID_EX),
    .STALL(STALL),
    .MUX_SEL(MUX_SEL)
);

initial begin

    $dumpfile("hazard_unit_tb.vcd");
    $dumpvars(0,hazard_unit_tb);

    MEMREAD_ID_EX = 0;
    ARS1_IF_ID = 5'b00001;
    ARS2_IF_ID = 5'b00010;
    ARD_ID_EX = 5'b00011;
    #10;
    //STALL = 0, MUX_SEL = 0


    MEMREAD_ID_EX = 1;
    ARS1_IF_ID = 5'b00001;
    ARS2_IF_ID = 5'b00010;
    ARD_ID_EX = 5'b00001;
    #10;
    //STALL = 1, MUX_SEL = 1


    MEMREAD_ID_EX = 1;
    ARS1_IF_ID = 5'b00001;
    ARS2_IF_ID = 5'b00010;
    ARD_ID_EX = 5'b00010;
    #10;
    //STALL = 1, MUX_SEL = 1


    MEMREAD_ID_EX = 1;
    ARS1_IF_ID = 5'b00011;
    ARS2_IF_ID = 5'b00100;
    ARD_ID_EX = 5'b00001;
    #10;
    //STALL = 0, MUX_SEL = 0


    MEMREAD_ID_EX = 1;
    ARS1_IF_ID = 5'b00010;
    ARS2_IF_ID = 5'b00010;
    ARD_ID_EX = 5'b00010;
    #10;
    //STALL = 1, MUX_SEL = 1


    $display("Test completado");
    $finish;


end



endmodule