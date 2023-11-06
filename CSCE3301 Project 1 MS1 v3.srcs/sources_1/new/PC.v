`timescale 1ns / 1ps

module PC(
input clk, rst, 
input wire [31:0]in,
output reg [31:0]out
 );
 
// always @ (posedge rst)begin
//    out = 32'b0;
// end

 
 
 always @(posedge clk or posedge rst) begin
    if (rst)
    out = 32'b0;
    else
    //out = in + 32'd4;
    out = in;
 end
 
 
endmodule
