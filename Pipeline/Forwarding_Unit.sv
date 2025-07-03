module forwarding_unit (
    input wire [4:0] ARD_EX_MEM, ARD_MEM_WB, ARS1, ARS2,
    input wire REGWRITE_EX_MEM, REGWRITE_MEM_WB,
    output reg [1:0] FORWARD_A, FORWARD_B
);
    

always_comb begin
    {FORWARD_A, FORWARD_B} = 4'b0000;
    if (
        REGWRITE_EX_MEM
        && (ARD_EX_MEM != 5'b00000)
        && (ARD_EX_MEM == ARS1)
    ) 
    begin
        FORWARD_A = 2'b10;
    end  
    
    if (
        REGWRITE_EX_MEM
        && (ARD_EX_MEM != 5'b00000)
        && (ARD_EX_MEM  == ARS2)
    ) 
    begin
        FORWARD_B = 2'b10;
    end
    
    if (
        REGWRITE_MEM_WB
        && (ARD_MEM_WB != 5'b00000)
        && !(REGWRITE_EX_MEM && (ARD_EX_MEM != 5'b00000)
            && (ARD_EX_MEM == ARS1))
        && (ARD_MEM_WB == ARS1)
    ) 
    begin
        FORWARD_A = 2'b01;
    end
    
    if (
        REGWRITE_MEM_WB
        && (ARD_MEM_WB != 5'b00000)
        && !(REGWRITE_EX_MEM && (ARD_EX_MEM != 5'b00000)
            && (ARD_EX_MEM == ARS2))
        && (ARD_MEM_WB == ARS2)
    ) 
    begin
        FORWARD_B = 2'b01;
    end
    

end

endmodule
