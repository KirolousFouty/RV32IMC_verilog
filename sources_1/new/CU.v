`timescale 1ns / 1ps


module CU( 
input [6:2]inst, 
output reg branch, MemRead, MemtoReg, 
output reg [1:0]ALUop, 
output reg MemWrite, ALUsrc, RegWrite

    );
    
    always@(*) begin
        if(inst == 5'b01100) begin   //R-Format
            branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUop = 2'b10;
            MemWrite = 0;
            ALUsrc = 0;
            RegWrite = 1;
        end
         else if(inst == 5'b00000 ) begin   //Load word
            branch = 0;
            MemRead = 1;
            MemtoReg = 1;
            ALUop = 2'b00;
            MemWrite = 0;
            ALUsrc = 1;
            RegWrite = 1;
        end
         else if(inst == 5'b01000) begin   //Store word
            branch = 0;
            MemRead = 0;
            MemtoReg = 0;  //don't care, so assigned to 0
            ALUop = 2'b00;
            MemWrite = 1;
            ALUsrc = 1;
            RegWrite = 0;
        end
      else if(inst == 5'b11000) begin   //BEQ
            branch = 1;
            MemRead = 0;
            MemtoReg = 0; //don't care, so assigned to 0
            ALUop = 2'b01;
            MemWrite = 0;
            ALUsrc = 0;
            RegWrite = 0;
        end
    
    
    end
    
    
    
    
    
    
endmodule
