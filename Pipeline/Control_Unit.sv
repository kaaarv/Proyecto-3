module control_unit #(parameter WIDTH=32) (
    input wire [WIDTH-1:0] INSTRUCTION,

    output reg [3:0] ALUOP,
    output reg PCSRC, ALUSRC, MEMTOREAD, MEMWRITE, MEMTOREG, REGWRITE
);
    
localparam [6:0] beq_op = 7'b1100011;
localparam [6:0] arit_op = 7'b0110011;
localparam [6:0] sw_op = 7'b0100011;
localparam [6:0] lw_op = 7'b0000011;

reg [3:0] funct7_funct3;

always @(*) begin
    funct7_funct3 = {INSTRUCTION[30], INSTRUCTION[14:12]};
    MEMTOREAD = 1'b0;
    case (INSTRUCTION[6:0])
        beq_op: begin
            {PCSRC,MEMTOREG,MEMWRITE,ALUSRC,REGWRITE}=5'b10000;
            ALUOP=4'b0110;
        end
        sw_op: begin
            {PCSRC,MEMTOREG,MEMWRITE,ALUSRC,REGWRITE}=5'b00110;
            ALUOP=4'b0010;
        end
        lw_op: begin
            {PCSRC,MEMTOREG,MEMWRITE,ALUSRC,REGWRITE}=5'b01011;
            ALUOP=4'b0010;
            MEMTOREAD = 1'b1;
        end
        arit_op: begin
        case (funct7_funct3)
            4'b1000: begin //resta
                {PCSRC,MEMTOREG,MEMWRITE,ALUSRC,REGWRITE}=5'b00001;
                 ALUOP=4'b0110;
            end
            4'b0000: begin //suma
                {PCSRC,MEMTOREG,MEMWRITE,ALUSRC,REGWRITE}=5'b00001;
                 ALUOP=4'b0010;
            end
              4'b0110: begin //or
                {PCSRC,MEMTOREG,MEMWRITE,ALUSRC,REGWRITE}=5'b00001;
                 ALUOP=4'b0001;
            end
             4'b0111: begin //and
                {PCSRC,MEMTOREG,MEMWRITE,ALUSRC,REGWRITE}=5'b00001;
                 ALUOP=4'b0000;
            end
             default: begin
                {PCSRC,MEMTOREG,MEMWRITE,ALUSRC,REGWRITE}=5'b1111;
                ALUOP=4'b1111;
             end   


        endcase
        end

        default: begin
            {PCSRC,MEMTOREG,MEMWRITE,ALUSRC,REGWRITE}=5'b1111;
            ALUOP=4'b1111;
        end
    endcase
        
end


endmodule
