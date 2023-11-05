`timescale 1ns / 1ps


module RCA #(parameter N = 8) (
    input [N-1:0]A,
    input [N-1:0]B,
    output [N:0]Sum
  
    );
    genvar i;
    wire [N:0]cout;

   
   assign cout[0] = 1'b0;
    generate
    for(i=0; i<N; i=i+1)begin
    FA inst(.A(A[i]), .B(B[i]), .Cin(cout[i]), .Sum(Sum[i]) , .Cout(cout[i+1]));
    end
    endgenerate
    assign Sum[N] = cout[N];

endmodule
