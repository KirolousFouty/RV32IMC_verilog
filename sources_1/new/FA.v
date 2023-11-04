`timescale 1ns / 1ps


module FA(
    input A,
    input B,
    input Cin,
    output  Sum,
    output  Cout
    );
    
    assign {Cout, Sum} = A + B + Cin;
    
    
endmodule
