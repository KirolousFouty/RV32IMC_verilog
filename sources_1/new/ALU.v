`timescale 1ns / 1ps

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
    4'b0000: ALUOutput = A & B; // and 
    4'b0001: ALUOutput = A | B; // or
    4'b0010: ALUOutput = w1; // add
    4'b0110: ALUOutput = w1; // sub
    default: ALUOutput = 32'd99;
    
endcase
end

always @(*) begin

zeroFlag = ALUOutput ? 0 : 1;

end



endmodule
