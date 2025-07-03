module signextend #(parameter WIDTH=32)(
    input wire [WIDTH-1:0] IN,
    output reg [WIDTH-1:0] OUT
);

/*
NOTA: Este módulo se debería de modificar en caso de que se quisieran implementar más instrucciones,
además la extensión de signo añade 20 bits al inmediato, asumiendo que el tamaño de palabra tiene
32 bits.
*/

always @(*) begin  
    case (IN[6:0])
        7'b0000011: OUT={{20{IN[31]}},IN[31:20]}; //lw 
        7'b0100011: OUT={{20{IN[31]}},IN[31:25],IN[11:7]};//sw
        7'b1100011: OUT={{20{IN[31]}},IN[31],IN[7],IN[30:25],IN[11:8]};//beq
        default: 
        OUT={WIDTH{1'b0}}; //En caso de que no sea una operacion que requiera inmediatos el modulo retorna
                 //una palabra de 0s.
    endcase
end
    
endmodule