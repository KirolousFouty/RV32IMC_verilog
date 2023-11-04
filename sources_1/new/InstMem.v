`timescale 1ns / 1ps

module InstMem (input [5:0] addr, output [31:0] data_out);
 reg [31:0] mem [0:63];
 assign data_out = mem[addr];


initial begin
// mem[0]=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)
// mem[1]=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)
// mem[2]=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)
// mem[3]=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2
// mem[4]=32'b0_000000_00011_00100_000_0100_0_1100011; //beq x4, x3, 4
// mem[5]=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2
// mem[6]=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2
// mem[7]=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0)
// mem[8]=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)
// mem[9]=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1
// mem[10]=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2
// mem[11]=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2
// mem[12]=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1
mem[0]=32'b00000000000000000010001010000011;
mem[1]=32'b00000000010000000010001100000011;
mem[2]=32'b00000000011000101000001110110011;
mem[3]=32'b00000000011000111110111000110011;
mem[4]=32'b00000000011111100111111010110011;
mem[5]=32'b01000001110111100000111100110011;
mem[6]=32'b00000000010111110110111110110011;
mem[7]=32'b00000001111100000010010000100011;
mem[8]=32'b00000001110011100000111000110011;
mem[9]=32'b00000000110000000010111110000011;
mem[10]=32'b00000001000000000010001100000011;
mem[11]=32'b01000000011011111000111110110011;
mem[12]=32'b00000000000011111000010001100011;
mem[13]=32'b11111110000000000000110011100011;
mem[14]=32'b00000000000000000000000000110011;
 end
 
endmodule