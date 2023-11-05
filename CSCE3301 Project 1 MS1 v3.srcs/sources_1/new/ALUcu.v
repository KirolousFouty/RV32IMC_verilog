`timescale 1ns / 1ps
`include "defines.v"

module ALUcu( input [1:0]ALUop, input [2:0]funct3, input [6:0]funct7, output reg [3:0]ALUsel);
    
//    always@(*) begin
//        if(ALUop == 2'b00) //ADD
//        ALUsel = 4'b0010;
//        else if(ALUop == 2'b01) //SUB
//        ALUsel = 4'b0110;
//     else if(ALUop == 2'b10 && inst2 == 1'b0 && inst == 3'b000)
//        ALUsel = 4'b0010;  //add
//         else if(ALUop == 2'b10 && inst2 == 1'b1 && inst == 3'b000)
//        ALUsel = 4'b0110;  //sub
//          else if(ALUop == 2'b10 && inst2 == 1'b0 && inst == 3'b111)
//        ALUsel = 4'b0000;  //And
//          else if(ALUop == 2'b10 && inst2 == 1'b0 && inst == 3'b110)
//        ALUsel = 4'b0001;  //OR
//    end
    
   
    always @(*) begin
        case (ALUop)
            2'b00: ALUsel = 4'b00_00; //add
            2'b01: ALUsel = 4'b00_01;  //sub
            2'b10:
            begin
                case(funct3)
                    `F3_ADD: 
                        begin
                            if (funct7 == 7'b0000000)
                            ALUsel = 4'b00_00;
                            else if (funct7 == 7'b0100000)
                            ALUsel = 4'b00_01; // SUB
                        end
                    `F3_SLL: ALUsel = 4'b10_01;
                    `F3_SLT: ALUsel = 4'b11_01;
                    `F3_SLTU: ALUsel = 4'b11_11;
                    `F3_XOR: ALUsel = 4'b01_11;
                    `F3_SRL:
                        begin
                            if (funct7 == 7'b0000000)
                            ALUsel = 4'b10_00;
                            else if (funct7 == 7'b0100000)
                            ALUsel = 4'b10_10; // SRA
                        end
                    `F3_OR: ALUsel = 4'b01_00;
                    `F3_AND: ALUsel = 4'b01_01;
                    
                    default : ALUsel = 4'b00_00;
                endcase
            end
        default : ALUsel = 4'b00_00;            
        endcase
    end
      
    
endmodule
