`timescale 1ns / 1ps

module NbitShiftLeftOne#(parameter N = 32)(
input [N-1:0]in,
output [N-1:0]out
);

assign out = {in[N-2:0], 1'b0};

endmodule
