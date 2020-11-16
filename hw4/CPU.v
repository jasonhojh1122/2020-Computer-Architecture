module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;

// PC address
wire    [31:0]  PC_addr_o;
wire    [31:0]  PC_addr_i;

// Control
wire    [1:0]   ALUop_sig;
wire            ALUSrc_sig;
wire            RegWrite_sig;

// Instruction
wire    [31:0]  Instruction;
wire    [4:0]   RS1_addr;
wire    [4:0]   RS2_addr;
wire    [4:0]   RD_addr;
wire    [6:0]   Opcode;
wire    [11:0]  Imm;
wire    [9:0]   Funct;
assign  RS1_addr    = Instruction[19:15];
assign  RS2_addr    = Instruction[24:20];
assign  RD_addr     = Instruction[11:7];
assign  Opcode      = Instruction[6:0];
assign  Imm         = Instruction[31:20];
assign  Funct       = {Instruction[31:25], Instruction[14:12]};

// Register Data
wire    [31:0]  RS1_data;
wire    [31:0]  RS2_data;

// Sign Extend
wire    [31:0]  Imm_extended;  

// ALU
wire    [31:0]  ALUSrc_2_data;
wire    [31:0]  ALU_result;
wire            ALU_zero;

// ALU control
wire    [2:0]   ALU_ctrl_sig;

// Modules
Control Control(
    .Op_i       (Opcode),
    .ALUOp_o    (ALUop_sig),
    .ALUSrc_o   (ALUSrc_sig),
    .RegWrite_o (RegWrite_sig)
);

Adder Add_PC(
    .data1_in   (PC_addr_o),
    .data2_in   (32'd4),
    .data_o     (PC_addr_i)
);

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (PC_addr_i),
    .pc_o       (PC_addr_o)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (PC_addr_o),
    .instr_o    (Instruction)
);

Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i  (RS1_addr),
    .RS2addr_i  (RS2_addr),
    .RDaddr_i   (RD_addr),
    .RDdata_i   (ALU_result),
    .RegWrite_i (RegWrite_sig), 
    .RS1data_o  (RS1_data),
    .RS2data_o  (RS2_data)
);

MUX32 MUX_ALUSrc(
    .data1_i    (RS2_data),
    .data2_i    (Imm_extended),
    .select_i   (ALUSrc_sig),
    .data_o     (ALUSrc_2_data)
);

Sign_Extend Sign_Extend(
    .data_i     (Imm),
    .data_o     (Imm_extended)
);
  
ALU ALU(
    .data1_i    (RS1_data),
    .data2_i    (ALUSrc_2_data),
    .ALUCtrl_i  (ALU_ctrl_sig),
    .data_o     (ALU_result),
    .Zero_o     (ALU_zero)
);

ALU_Control ALU_Control(
    .funct_i    (Funct),
    .ALUOp_i    (ALUop_sig),
    .ALUCtrl_o  (ALU_ctrl_sig)
);

endmodule

