`timescale 1ns / 1ps


module CU( 
input [6:2]inst, 
output reg branch, MemRead, MemtoReg, 
output reg [1:0]ALUop, 
output reg MemWrite, ALUsrc, RegWrite,
output reg jump, jalr
);
    
    always@(*) begin
        if(inst == `OPCODE_Arith_R)
            begin   //R-Format
            branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUop = 2'b10;
            MemWrite = 0;
            ALUsrc = 0;
            RegWrite = 1;
            jump = 0;
			jalr = 0;
            end
        else if(inst == `OPCODE_Load)
            begin   //Load word
            branch = 0;
            MemRead = 1;
            MemtoReg = 1;
            ALUop = 2'b00;
            MemWrite = 0;
            ALUsrc = 1;
            RegWrite = 1;
            jump = 0;            
			jalr = 0;
            end
        else if(inst == `OPCODE_Store)
            begin   //Store word
            branch = 0;
            MemRead = 0;
            MemtoReg = 0;  //don't care, so assigned to 0
            ALUop = 2'b00;
            MemWrite = 1;
            ALUsrc = 1;
            RegWrite = 0;
            jump = 0;
			jalr = 0;
            end
        else if(inst == `OPCODE_Branch)
            begin   //BEQ
            branch = 1;
            MemRead = 0;
            MemtoReg = 0; //don't care, so assigned to 0
            ALUop = 2'b01;
            MemWrite = 0;
            ALUsrc = 0;
            RegWrite = 0;
            jump = 0;
			jalr = 0;
            end
        else if(inst == `OPCODE_LUI) // LUI
            begin
            branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUop = 2'b00; // ADD
            MemWrite = 0;
            ALUsrc = 1;
            RegWrite = 1;
            jump = 0;
			jalr = 0;
            end    
        else if(inst == `OPCODE_AUIPC) // AUIPC
            begin
            branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUop = 2'b00; // ADD
            MemWrite = 0;
            ALUsrc = 1;
            RegWrite = 1;
            jump = 0;
			jalr = 0;
            end
        else if(inst == `OPCODE_JAL) // JAL
            begin
            branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUop = 2'b00; // ADD
            MemWrite = 0;
            ALUsrc = 1;
            RegWrite = 1;
            jump = 1;
			jalr = 0;
            end
        else if(inst == `OPCODE_JALR) // JALR
			begin
			branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUop = 2'b00;
            MemWrite = 0;
            ALUsrc = 1;
            RegWrite = 1;
			jump = 1;
			jalr = 1;
			end    
        else if(inst == `OPCODE_Arith_I) // Arithmetic I-Format
			begin
			branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUop = 2'b10;
            MemWrite = 0;
            ALUsrc = 1;
            RegWrite = 1;
			jump = 0;
			jalr = 0;
			end
				
    end
    
    
    
    
    
    
endmodule