`include "defines.v"
`timescale 1ns / 1ps

module immGen(
input [31:0] in, output reg [31:0] out
    );
     
//    // lab 6    
//    always @(*)
//    begin
//    if(in[6:5] == 2'b00)
//    out = {{20{in[31]}}, in[31:20]};  //lw
//    else if(in[6:5] == 2'b01)
//    out = {{20{in[31]}} ,in[31:25], in[11:7]};  //sw
//    else if(in[6] == 1'b1)
//    out = {{19{in[31]}}, in[31], in[7], in[30:25], in[11:8]}; //beq
//    end
   
    always @(*) begin
	case (`OPCODE)
		`OPCODE_Arith_I   : 	Imm = { {21{IR[31]}}, IR[30:25], IR[24:21], IR[20] };
		`OPCODE_Store     :     Imm = { {21{IR[31]}}, IR[30:25], IR[11:8], IR[7] };
		`OPCODE_LUI       :     Imm = { IR[31], IR[30:20], IR[19:12], 12'b0 };
		`OPCODE_AUIPC     :     Imm = { IR[31], IR[30:20], IR[19:12], 12'b0 };
		`OPCODE_JAL       : 	Imm = { {12{IR[31]}}, IR[19:12], IR[20], IR[30:25], IR[24:21], 1'b0 };
		`OPCODE_JALR      : 	Imm = { {21{IR[31]}}, IR[30:25], IR[24:21], IR[20] };
		`OPCODE_Branch    : 	Imm = { {20{IR[31]}}, IR[7], IR[30:25], IR[11:8], 1'b0};
		default           : 	Imm = { {21{IR[31]}}, IR[30:25], IR[24:21], IR[20] }; // IMM_I
	endcase 
    end
    
   
    
    
endmodule
