module hazard_unit (
    
    input wire MEMREAD_ID_EX,
    input wire [4:0] ARS1_IF_ID, ARS2_IF_ID, ARD_ID_EX,
    output reg STALL, MUX_SEL
);


always_comb begin
    {STALL, MUX_SEL} = 2'b0;
    if (MEMREAD_ID_EX && ((ARD_ID_EX == ARS1_IF_ID) || (ARD_ID_EX == ARS2_IF_ID))){STALL, MUX_SEL} = 2'b11;
    else {STALL, MUX_SEL} = 2'b00;

end

endmodule
