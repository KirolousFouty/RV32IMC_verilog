`timescale 1ns / 1ps

module DataMem
 (input clk, input MemRead, input MemWrite,
 input [5:0] addr, input [31:0] data_in, output [31:0] data_out);
 reg [31:0] mem [0:63];

 assign data_out = MemRead ? mem[addr] : 32'b0;
 
 
 always @(posedge clk)begin
     if (MemWrite == 1)
     mem[addr] = data_in;
 end
 
 
 initial begin
//     mem[0]=32'd17;
//     mem[1]=32'd9;
//     mem[2]=32'd25;

mem[0] = 32'd3; // 0(x0)
mem[1] = 32'd7; // 4(x0)
// mem[2] is set by SW in instructions  // 8(x0)
mem[3] = 32'd3; // loop number of iterations  // 12(x0)
mem[4] = 32'd1;  // 16(x0)

 end 

 
endmodule

