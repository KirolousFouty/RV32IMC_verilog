`timescale 1ns / 1ps
`include "defines.v"

module ALU #(parameter N = 32)(
    input [3:0]sel,
    //input [N-1:0]in[15:0],
    input [N-1:0] A,B,
    output reg [N-1:0]ALUOutput,
    output reg zeroFlag
);

wire [N-1:0]w1;
wire [N-1:0]B1;
wire carryOut;
assign B1 = (sel[2]==1) ? ~B+1 : B;
RCA #(32)rca1(.A(A), .B(B1), .Sum({carryOut, w1})); // check sum output carry


always @(*)begin

case(sel)

    `ALU_ADD: ALUOutput = w1; // add
    `ALU_SUB: ALUOutput = w1; // sub
    `ALU_PASS: ALUOutput = A & B; // and 
    `ALU_OR: ALUOutput = A | B; // or
//    `ALU_AND:
//    `ALU_XOR:
//    `ALU_SRL:
//    `ALU_SRA:
//    `ALU_SLL:
//    `ALU_SLT:
//    `ALU_SLTU:    
    default: ALUOutput = 32'd99;
    
endcase
end

always @(*) begin

zeroFlag = ALUOutput ? 0 : 1;

end



endmodule
