`timescale 1ns / 1ps

module ALUcu( input [1:0]ALUop, input [14:12] inst, input inst2, output reg [3:0]ALUsel);
    
    always@(*) begin
        if(ALUop == 2'b00) //ADD
        ALUsel = 4'b0010;
        else if(ALUop == 2'b01) //SUB
        ALUsel = 4'b0110;
     else if(ALUop == 2'b10 && inst2 == 1'b0 && inst == 3'b000)
        ALUsel = 4'b0010;  //add
         else if(ALUop == 2'b10 && inst2 == 1'b1 && inst == 3'b000)
        ALUsel = 4'b0110;  //sub
          else if(ALUop == 2'b10 && inst2 == 1'b0 && inst == 3'b111)
        ALUsel = 4'b0000;  //And
          else if(ALUop == 2'b10 && inst2 == 1'b0 && inst == 3'b110)
        ALUsel = 4'b0001;  //OR
   
    end
    
   
    
endmodule
