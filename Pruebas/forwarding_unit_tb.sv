`timescale 1ns/1ns
`include "Forwarding_Unit.sv"

module forwarding_unit_tb (
);

    reg [4:0] ard_ex_mem;
    reg [4:0] ard_mem_wb; 
    reg [4:0] ars1;
    reg [4:0] ars2;
    reg regwrite_ex_mem;
    reg regwrite_mem_wb;
    wire [1:0] forward_a;
    wire [1:0] forward_b;



F dut (

    .ARD_EX_MEM(ard_ex_mem),
    .ARD_MEM_WB(ard_mem_wb),
    .ARS1(ars1),
    .ARS2(ars2),
    .REGWRITE_EX_MEM(regwrite_ex_mem),
    .REGWRITE_MEM_WB(regwrite_mem_wb),
    .FORWARD_A(forward_a),
    .FORWARD_B(forward_b)
);

initial begin

    $dumpfile("forwarding_unit_tb.vcd");
    $dumpvars(0,forwarding_unit_tb);


    //if 1 causa reenvio del registro 1 de ex mem si registro destino ard_ex_mem coincide con registro fuente ars1
    // Caso 1: No hay reenvío
    ard_ex_mem = 5'b00001;
    ard_mem_wb = 5'b00010;
    ars1 = 5'b00011;
    ars2 = 5'b00100;
    regwrite_ex_mem = 1'b0;
    regwrite_mem_wb = 1'b0;
    #10
    // forward_a = 2'b00
    // forward_b = 2'b00


    // Caso 2: Reenvío de EX/MEM a RS1
    ard_ex_mem = 5'b00011;
    ard_mem_wb = 5'b00100;
    ars1 = 5'b00011; //ard_ex_mem coincide con ars1 por lo que hay adelantamiento
    ars2 = 5'b00101;
    regwrite_ex_mem = 1'b1;
    regwrite_mem_wb = 1'b0;
    #10;  
    // forward_a = 2'b10
    // forward_b = 2'b00


    // Caso 3: No reenvío de EX/MEM a RS1 (regwrite_ex_mem = 0)
    ard_ex_mem = 5'b00011;
    ard_mem_wb = 5'b00100;
    ars1 = 5'b00011;
    ars2 = 5'b00101;
    regwrite_ex_mem = 1'b0;
    regwrite_mem_wb = 1'b0;
    #10;
    // forward_a = 2'b00
    // forward_b = 2'b00




    //if 2 causa reenvio del registro 2 de ex mem si registro destino ard_ex_mem coincide con registro fuente ars2
    // Caso 4: Reenvío de EX/MEM a RS2
    ard_ex_mem = 5'b00101;
    ard_mem_wb = 5'b00110;
    ars1 = 5'b00011;
    ars2 = 5'b00101;
    regwrite_ex_mem = 1'b1;
    regwrite_mem_wb = 1'b0;
    #10;
    // forward_a = 2'b00
    // forward_b = 2'b10


    // Caso 5: No reenvío de EX/MEM a RS2 (regwrite_ex_mem = 0)
    ard_ex_mem = 5'b00101;
    ard_mem_wb = 5'b00110;
    ars1 = 5'b00011;
    ars2 = 5'b00101;
    regwrite_ex_mem = 1'b0;
    regwrite_mem_wb = 1'b0;
    #10;
    // forward_a = 2'b00
    // forward_b = 2'b00




    //if 3 causa reenvio de registro 1 de mem wb si registro destino ard_mem_wb coincide con registro fuente ars1
    // Caso 6: Reenvío de MEM/WB a RS1
    ard_ex_mem = 5'b00010;
    ard_mem_wb = 5'b00111;
    ars1 = 5'b00111;
    ars2 = 5'b01000;
    regwrite_ex_mem = 1'b0;
    regwrite_mem_wb = 1'b1;
    #10;
    // forward_a = 2'b01
    // forward_b = 2'b00


    // Caso 7: No reenvío de MEM/WB a RS1 (regwrite_mem_wb = 0)
    ard_ex_mem = 5'b00010;
    ard_mem_wb = 5'b00111;
    ars1 = 5'b00111;
    ars2 = 5'b01000;
    regwrite_ex_mem = 1'b0;
    regwrite_mem_wb = 1'b0;
    #10;
    // forward_a = 2'b00
    // forward_b = 2'b00




    //if 4 causa reenvio de registro 2 de mem wb si registro destino ard_mem_wb coincide con registro fuente ars2
    // Caso 8: Reenvío de MEM/WB a RS2
    ard_ex_mem = 5'b00001;
    ard_mem_wb = 5'b01000;
    ars1 = 5'b00111;
    ars2 = 5'b01000;
    regwrite_ex_mem = 1'b0;
    regwrite_mem_wb = 1'b1;
    #10;
    // forward_a = 2'b00
    // forward_b = 2'b01


    // Caso 9: No reenvío de MEM/WB a RS2 (regwrite_mem_wb = 0)
    ard_ex_mem = 5'b00001;
    ard_mem_wb = 5'b01000;
    ars1 = 5'b00111;
    ars2 = 5'b01000;
    regwrite_ex_mem = 1'b0;
    regwrite_mem_wb = 1'b0;
    #10;
    // forward_a = 2'b00
    // forward_b = 2'b00




    // DOBLE REENVIO
    // Caso 10: Reenvío desde EX/MEM a RS1 y MEM/WB a RS2
    ard_ex_mem = 5'b01001;
    ard_mem_wb = 5'b01010;
    ars1 = 5'b01001;
    ars2 = 5'b01010;
    regwrite_ex_mem = 1'b1;
    regwrite_mem_wb = 1'b1;
    #10;
    // forward_a = 2'b10
    // forward_b = 2'b01

    // Caso 11: No reenvío desde EX/MEM y MEM/WB a RS1 y RS2 (regwrite_ex_mem = 0 y regwrite_mem_wb = 0)
    ard_ex_mem = 5'b01001;
    ard_mem_wb = 5'b01010;
    ars1 = 5'b01001;
    ars2 = 5'b01010;
    regwrite_ex_mem = 1'b0;
    regwrite_mem_wb = 1'b0;
    #10;
    // forward_a = 2'b00
    // forward_b = 2'b00


    $display("Test completado");
    $finish;
end



endmodule