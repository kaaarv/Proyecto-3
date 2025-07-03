module data_mem (
    input wire clk,rst,wrt_en,
    input wire [10:0] address,
    input wire [31:0] write_data,
    output reg [31:0] read_data
);

reg [7:0] memory [2047:0]; //el primer valor es width, el segundo depth.
integer i;
always @(posedge clk) begin

    if(!rst) begin  
    for(i=0;i<2048;i=i+1) begin
        memory[i]<={8{1'b0}}; //caso de reset en bajo, colocar todos los registros en 0.
    end
    end
    
    if (wrt_en) begin
        {
         memory[address+3],
         memory[address+2],
         memory[address+1],
         memory[address]
         } <=write_data;
    end
    
end


always @(*) begin 
    read_data={
         memory[address+3],
         memory[address+2],
         memory[address+1],
         memory[address]
         };
end


endmodule