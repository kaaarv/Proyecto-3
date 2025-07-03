module registers #(parameter WIDTH=32,DEPTH=32)(
    input wire clk, rst,
    input wire REGWRITE,

    input wire [$clog2(DEPTH)-1:0] ADR_REG1, ADR_REG2, ADR_WR_REG, //direcciones de registros .

    input wire [WIDTH-1:0] WR_DATA, //dato para escritura.

    output wire [WIDTH-1:0] REG_DATA1, REG_DATA2 //salidas de registros.
);

reg [WIDTH-1:0] register_bank [DEPTH-1:0];

always_ff @(negedge clk) begin // clk negado en caso de escritura y lectura en mismo ciclo!!!!
    
    if(REGWRITE && (ADR_WR_REG!={$clog2(DEPTH){1'b0}})) begin //nunca escribir en registro x0
         register_bank [ADR_WR_REG] <=WR_DATA;
    end

    if(!rst) begin  
    for(integer i=0;i<DEPTH;i=i+1) begin
        register_bank[i]<={WIDTH{1'b0}};
        end
    end

end

assign REG_DATA1=(ADR_REG1!={$clog2(DEPTH){1'b0}})?register_bank[ADR_REG1]:{WIDTH{1'b0}}; //si se lee registro x0 mostrar 0
assign REG_DATA2=(ADR_REG2!={$clog2(DEPTH){1'b0}})?register_bank[ADR_REG2]:{WIDTH{1'b0}}; //si se lee registro x0 mostrar 0
    
endmodule
