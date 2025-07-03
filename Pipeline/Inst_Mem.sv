//este modulo tiene la caracteristica de que tiene una entrada de direccion de 
//64 bits, por lo que se podrían direccionar teóricamente 2^64-1 espacios en memoria.
//Ningun sistema real utiliza esta cantidad de memoria, por lo que únicamente se generaro
//80 espacios en memoria.

module inst_mem #(parameter width=32,depth=2048,adr_in=11)
(
    input wire clk,rst,
    input wire [adr_in-1:0] read_adr,
    output reg [width-1:0] instruction
);

    
 reg [width-1:0] memory [depth-1:0]; 
integer i;

always @(*) instruction= memory[read_adr];


endmodule