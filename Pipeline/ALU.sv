module alu #(parameter WIDTH=32)(
    input wire [WIDTH-1:0] A,B,
    input wire [3:0] ALU_OPERATION,

    output reg [WIDTH-1:0] ALU_RESULT
);
    
/*
Para añadir más instrucciones es necesario añadir las nuevas operaciones en esta ALU
*/

always @(*) begin 
    case (ALU_OPERATION)
        4'b0000:   ALU_RESULT=A&B;
        4'b0001:   ALU_RESULT=A|B;
        4'b0010:   ALU_RESULT=A+B;
        4'b0110:   ALU_RESULT=A-B;
        default: ALU_RESULT={WIDTH{1'b1}}; //Generar WIDTH bits de 0 en caso de que se seleccione
    endcase                             //una operación inválida.
end



endmodule