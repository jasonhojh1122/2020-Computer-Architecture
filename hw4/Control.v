module Control
(
    Op_i,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o
);

input  [6:0]    Op_i;
output [1:0]    ALUOp_o;
output          ALUSrc_o;
output          RegWrite_o;

reg [1:0]       ALUOp_reg;
reg             ALUSrc_reg;

assign ALUOp_o      = ALUOp_reg;
assign ALUSrc_o     = ALUSrc_reg;
assign RegWrite_o   = 1;

always@(*) begin
    case (Op_i)
        7'b0110011: begin // and xor sll add sub mul
            ALUOp_reg   = 2'b00;
            ALUSrc_reg  = 0;
        end
        7'b0010011: begin // addi srai
            ALUOp_reg   = 2'b01;
            ALUSrc_reg  = 1;
        end
        default: begin
            ALUOp_reg   = 2'b00;
            ALUSrc_reg  = 0;
        end
    endcase
end

endmodule