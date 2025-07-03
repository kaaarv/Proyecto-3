
`include "Adder.sv"
`include "ALU.sv"
`include "And.sv"
`include "Branch_Comp.sv"
`include "Control_Unit.sv"
`include "Forwarding_Unit.sv"
`include "Hazard_Unit.sv"
`include "Mux2_1.sv"
`include "Mux4_1.sv"
`include "PC.sv"
`include "Pipe_EX_MEM.sv"
`include "Pipe_ID_EX.sv"
`include "Pipe_IF_ID.sv"
`include "Pipe_MEM_WB.sv"
`include "Registers.sv"
`include "Sign_Extend.sv"
`include "Data_Mem.sv"
`include "Inst_Mem.sv"




module pipeline_top #(
    parameter WIDTH = 32
)(
    input wire rst,
    input wire clk
);

wire [WIDTH-1:0] pc_mux_to_pc;
wire [WIDTH-1:0] pc_to_inst_mem;
wire [WIDTH-1:0] pc_adder_to_pc_mux;
wire [WIDTH-1:0] inst_mem_to_inst_pipe;

wire [WIDTH-1:0] instruction;
wire [WIDTH-1:0] register_1;
wire [WIDTH-1:0] register_2;
wire register_1_equals_register_2;
wire [WIDTH-1:0] pipe_pc_passthrough;
wire [WIDTH-1:0] imm_adder_to_pc_mux;
wire [WIDTH-1:0] immediate_sexted;
wire [3:0] alu_operation;
wire stall_signal_for_mux;
reg  [8:0] control_signals_to_be_muxed;
wire control_pcsrc;
wire control_alusrc_to_mux;
wire control_memtoread_to_mux;
wire control_memwrite_to_mux;
wire control_memtoreg_to_mux;
wire control_regwrite_to_mux;
wire and_branch_was_taken;
wire hazard_unit_stall_signal;
wire hazard_unit_pcwrite_signal;

assign control_signals_to_be_muxed = {
    alu_operation,
    control_alusrc_to_mux,
    control_regwrite_to_mux,
    control_memtoreg_to_mux,
    control_memwrite_to_mux,
    control_memtoread_to_mux
};

wire [8:0] control_signals_from_mux;

reg [3:0] mux_aluop_to_id_ex;
reg mux_alusrc_to_id_ex;
reg mux_memtoread_to_id_ex;
reg mux_memwrite_to_id_ex;
reg mux_memtoreg_to_id_ex;
reg mux_regwrite_to_id_ex;

always_comb begin

    {
        mux_aluop_to_id_ex,
        mux_alusrc_to_id_ex,
        mux_regwrite_to_id_ex,
        mux_memtoreg_to_id_ex,
        mux_memwrite_to_id_ex,
        mux_memtoread_to_id_ex
    } = control_signals_from_mux;

end 

wire [3:0] id_ex_aluop_to_alu;
wire id_ex_alusrc_to_alusrc_mux;
wire id_ex_memtoread_to_hazards;
wire id_ex_memwrite_to_ex_mem;
wire id_ex_memtoreg_to_ex_mem;
wire id_ex_regwrite_to_ex_mem;

wire [WIDTH-1:0] id_ex_rs1_to_forward_a_mux;
wire [WIDTH-1:0] id_ex_rs2_to_forward_b_mux;
wire [4:0] id_ex_a_rs1_to_forwarding;
wire [4:0] id_ex_a_rs2_to_forwarding;
wire [4:0] id_ex_a_rd_to_ex_mem;
wire [WIDTH-1:0] id_ex_imm_sexted_to_alu_src_mux;

wire [WIDTH-1:0] forward_a_mux_to_alu_a_in;
wire [WIDTH-1:0] forward_b_mux_to_alu_src_mux;
wire [WIDTH-1:0] alu_src_mux_to_alu_b_in;
wire [WIDTH-1:0] alu_out_to_ex_mem_pipe;
wire [1:0] forwarding_forward_a_sel_signal;
wire [1:0] forwarding_forward_b_sel_signal;

wire ex_mem_memwrite_to_data_mem;
wire ex_mem_memtoreg_to_mem_wb;
wire ex_mem_regwrite_to_mem_wb;
wire [WIDTH-1:0] ex_mem_result_op_to_data_mem;
wire [WIDTH-1:0] ex_mem_wr_data_to_data_mem;
wire [4:0] ex_mem_a_rd_to_mem_wb;

wire [WIDTH-1:0] data_mem_out_to_mem_wb;
wire mem_wb_memtoreg_to_data_mem_skip_mux;
wire mem_wb_regwrite_to_registers;
wire [WIDTH-1:0] data_read_to_data_mem_skip_mux;
wire [WIDTH-1:0] result_op_to_data_mem_skip_mux;
wire [4:0] mem_wb_a_rd_to_registers;
wire [WIDTH-1:0] data_mem_skip_mux_out_to_registers;

mux21 PC_MUX(
    .SEL(and_branch_was_taken),
    .IN0(pc_adder_to_pc_mux),
    .IN1(imm_adder_to_pc_mux),
    .OUT(pc_mux_to_pc)
);

pc PC(
    .clk(clk),
    .rst(rst),
    .STALL(hazard_unit_stall_signal),
    .IN(pc_mux_to_pc),
    .OUT(pc_to_inst_mem)
);

reg [10:0] by_byte_addressing_to_by_word;
assign by_byte_addressing_to_by_word = pc_to_inst_mem[12:2];


inst_mem INST_MEM(
    .clk(clk),
    .rst(rst),
    .read_adr(by_byte_addressing_to_by_word),
    .instruction(inst_mem_to_inst_pipe)
);


adder PC_ADDER(
    .A(pc_to_inst_mem),
    .B(32'h00000004),
    .Q(pc_adder_to_pc_mux)
);

pipe_if_id PIPE_IF_ID(
    .clk(clk),
    .rst(rst),
    .FLUSH(and_branch_was_taken),
    .STALL(hazard_unit_stall_signal),
    .PC_IN(pc_to_inst_mem),
    .INSTRUCTION_IN(inst_mem_to_inst_pipe),
    .PC_OUT(pipe_pc_passthrough),
    .INSTRUCTION_OUT(instruction)
);

reg [4:0] add_reg_1;
reg [4:0] add_reg_2;

always_comb begin
    add_reg_1 = instruction[19:15];
    add_reg_2 = instruction[24:20];
end 

registers REGISTERS(
    .clk(clk),
    .rst(rst),
    .REGWRITE(mem_wb_regwrite_to_registers),
    .ADR_REG1(add_reg_1),
    .ADR_REG2(add_reg_2),
    .ADR_WR_REG(mem_wb_a_rd_to_registers),
    .WR_DATA(data_mem_skip_mux_out_to_registers),
    .REG_DATA1(register_1),
    .REG_DATA2(register_2)
);

branch_comp BRANCH_COMPARE(
    .IN1(register_1),
    .IN2(register_2),
    .OUT(register_1_equals_register_2)
);

adder IMM_ADDER(
    .A(pipe_pc_passthrough),
    .B(immediate_sexted),
    .Q(imm_adder_to_pc_mux)
);

signextend IMM_GEN_SIGN_EXTENDED(
    .IN(instruction),
    .OUT(immediate_sexted)
);

control_unit CONTROL_UNIT(
    .INSTRUCTION(instruction),
    .ALUOP(alu_operation),
    .PCSRC(control_pcsrc),
    .ALUSRC(control_alusrc_to_mux),
    .MEMTOREAD(control_memtoread_to_mux),
    .MEMWRITE(control_memwrite_to_mux),
    .MEMTOREG(control_memtoreg_to_mux),
    .REGWRITE(control_regwrite_to_mux)
);

and1 AND_BRANCHING(
    .A(register_1_equals_register_2),
    .B(control_pcsrc),
    .Q(and_branch_was_taken)
);

mux21 #(9) STALL_CONTROL_MUX (
    .SEL(stall_signal_for_mux),
    .IN0(control_signals_to_be_muxed),
    .IN1({9'b0}),
    .OUT(control_signals_from_mux)
);

reg [4:0] ad_reg_rd ;
assign ad_reg_rd = instruction[11:7];

pipe_id_ex PIPE_ID_EX(
    .clk(clk),
    .rst(rst),
    .ALUOP_IN(mux_aluop_to_id_ex),
    .ALUSRC_IN(mux_alusrc_to_id_ex),
    .REGWRITE_IN(mux_regwrite_to_id_ex),
    .MEMTOREG_IN(mux_memtoreg_to_id_ex),
    .MEMWRITE_IN(mux_memwrite_to_id_ex),
    .MEMREAD_IN(mux_memtoread_to_id_ex),
    .ARS1_IN(add_reg_1),
    .ARS2_IN(add_reg_2),
    .ARD_IN(ad_reg_rd),
    .RS1_IN(register_1),
    .RS2_IN(register_2),
    .IMMEDIATE_IN(immediate_sexted),

    .ALUOP_OUT(id_ex_aluop_to_alu),
    .ALUSRC_OUT(id_ex_alusrc_to_alusrc_mux),
    .REGWRITE_OUT(id_ex_regwrite_to_ex_mem),
    .MEMTOREG_OUT(id_ex_memtoreg_to_ex_mem),
    .MEMWRITE_OUT(id_ex_memwrite_to_ex_mem),
    .MEMREAD_OUT(id_ex_memtoread_to_hazards),
    .ARS1_OUT(id_ex_a_rs1_to_forwarding),
    .ARS2_OUT(id_ex_a_rs2_to_forwarding),
    .ARD_OUT(id_ex_a_rd_to_ex_mem),
    .RS1_OUT(id_ex_rs1_to_forward_a_mux),
    .RS2_OUT(id_ex_rs2_to_forward_b_mux),
    .IMMEDIATE_OUT(id_ex_imm_sexted_to_alu_src_mux)
);

reg [6:0] op_code ;
assign op_code = instruction[6:0];

hazard_unit HAZARD_UNIT(
    .MEMREAD_ID_EX(id_ex_memtoread_to_hazards),
    //.BEQ_WRONG_PRED(register_1_equals_register_2),
    //.OP_CODE(op_code),
    .ARS1_IF_ID(add_reg_1),
    .ARS2_IF_ID(add_reg_2),
    .ARD_ID_EX(id_ex_a_rd_to_ex_mem),
    .STALL(hazard_unit_stall_signal),
    .MUX_SEL(stall_signal_for_mux)
);

mux41 FORWARD_A_MUX(
    .SEL(forwarding_forward_a_sel_signal),
    .IN0(id_ex_rs1_to_forward_a_mux),
    .IN2(ex_mem_result_op_to_data_mem),
    .IN1(data_mem_skip_mux_out_to_registers),
    .IN3({32'b0}),
    .OUT(forward_a_mux_to_alu_a_in)
);

mux41 FORWARD_B_MUX(
    .SEL(forwarding_forward_b_sel_signal),
    .IN0(id_ex_rs2_to_forward_b_mux),
    .IN2(ex_mem_result_op_to_data_mem),
    .IN1(data_mem_skip_mux_out_to_registers),
    .IN3({32'b0}),
    .OUT(forward_b_mux_to_alu_src_mux)
);

mux21 ALUSRC_MUX(
    .SEL(id_ex_alusrc_to_alusrc_mux),
    .IN0(forward_b_mux_to_alu_src_mux),
    .IN1(id_ex_imm_sexted_to_alu_src_mux),
    .OUT(alu_src_mux_to_alu_b_in)
);

alu ALU(
    .A(forward_a_mux_to_alu_a_in),
    .B(alu_src_mux_to_alu_b_in),
    .ALU_OPERATION(id_ex_aluop_to_alu),
    .ALU_RESULT(alu_out_to_ex_mem_pipe)
);

pipe_ex_mem PIPE_EX_MEM(
    .clk(clk),
    .rst(rst),
    .MEMWRITE_IN(id_ex_memwrite_to_ex_mem),
    .MEMTOREG_IN(id_ex_memtoreg_to_ex_mem),
    .REGWRITE_IN(id_ex_regwrite_to_ex_mem),
    .RESULTOP_IN(alu_out_to_ex_mem_pipe),
    .WRDATA_IN(forward_b_mux_to_alu_src_mux),
    .ARD_IN(id_ex_a_rd_to_ex_mem),

    .MEMWRITE_OUT(ex_mem_memwrite_to_data_mem),
    .MEMTOREG_OUT(ex_mem_memtoreg_to_mem_wb),
    .REGWRITE_OUT(ex_mem_regwrite_to_mem_wb),
    .RESULTOP_OUT(ex_mem_result_op_to_data_mem),
    .WRDATA_OUT(ex_mem_wr_data_to_data_mem),
    .ARD_OUT(ex_mem_a_rd_to_mem_wb)
);

forwarding_unit FORWARDING_UNIT(
    .ARD_EX_MEM(ex_mem_a_rd_to_mem_wb),
    .ARD_MEM_WB(mem_wb_a_rd_to_registers),
    .ARS1(id_ex_a_rs1_to_forwarding),
    .ARS2(id_ex_a_rs2_to_forwarding),
    .REGWRITE_EX_MEM(ex_mem_regwrite_to_mem_wb),
    .REGWRITE_MEM_WB(mem_wb_regwrite_to_registers),
    .FORWARD_A(forwarding_forward_a_sel_signal),
    .FORWARD_B(forwarding_forward_b_sel_signal)
);


data_mem DATA_MEM(
    .clk(clk),
    .rst(rst),
    .wrt_en(ex_mem_memwrite_to_data_mem),
    .address(ex_mem_result_op_to_data_mem[10:0]),
    .write_data(ex_mem_wr_data_to_data_mem),
    .read_data(data_mem_out_to_mem_wb)
);



pipe_mem_wb PIPE_MEM_WB(
    .clk(clk),
    .rst(rst),
    .MEMTOREG_IN(ex_mem_memtoreg_to_mem_wb),
    .REGWRITE_IN(ex_mem_regwrite_to_mem_wb),
    .MEMDATA_IN(data_mem_out_to_mem_wb),
    .RESULTOP_IN(ex_mem_result_op_to_data_mem),
    .ARD_IN(ex_mem_a_rd_to_mem_wb),
    .MEMTOREG_OUT(mem_wb_memtoreg_to_data_mem_skip_mux),
    .REGWRITE_OUT(mem_wb_regwrite_to_registers),
    .MEMDATA_OUT(data_read_to_data_mem_skip_mux),
    .RESULTOP_OUT(result_op_to_data_mem_skip_mux),
    .ARD_OUT(mem_wb_a_rd_to_registers)

);

mux21 MEM_TO_REG_MUX(
    .SEL(mem_wb_memtoreg_to_data_mem_skip_mux),
    .IN1(data_read_to_data_mem_skip_mux),
    .IN0(result_op_to_data_mem_skip_mux),
    .OUT(data_mem_skip_mux_out_to_registers)
);

endmodule
