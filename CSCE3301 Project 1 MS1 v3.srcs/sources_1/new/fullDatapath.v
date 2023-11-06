`timescale 1ns / 1ps
`include "defines.v"

module fullDatapath(
input clk, ssdClk, rst,
output reg [15:0]LEDs,
input [1:0]ledSel,
output [6:0]LED_out,
output [3:0]Anode,
input [3:0]ssdSel
);
    
    // todo: PC
  
    localparam N = 32;
      
    // wire [5:0] addr; // connected to PC
    wire [31:0] IR;
    
    wire branch_inst, MemRead, MemtoReg;
    wire [1:0]ALUop;
    wire MemWrite, ALUsrc, RegWrite;
    wire jump;
    wire jalr;

    wire [N-1:0]writeData; // todo: check writeData in RegisterFile
    wire [N-1:0]readData1, readData2;

    wire [31:0] immGenOut;

    wire [3:0]ALUsel;
    
    wire [31:0]MUX_ALU;
    
    wire [N-1:0]ALUOutput;
//    wire zeroFlag;
    
    wire [31:0] data_out;
    
    wire [31:0] MUX_RegisterWriteData;
    
//    wire [N-1:0]shiftOut;
    
    wire [31:0]sumOut;
    wire [31:0]PCout;
    
    wire [31:0]MUX_PC;
    
    wire [31:0]addOut;
    
    reg [12:0]SSD;
    
    InstMem InstMem1(.addr(PCout[7:2]), .data_out(IR));
        
    CU CU1(.inst(IR[`IR_opcode]),
    .branch(branch_inst), .MemRead(MemRead), .MemtoReg(MemtoReg), 
    .ALUop(ALUop), 
    .MemWrite(MemWrite), .ALUsrc(ALUsrc), .RegWrite(RegWrite),
    .jump(jump), .jalr(jalr)
    );
    
    assign writeData = jump ? addOut : MUX_RegisterWriteData; // TODO: check if addOut, declared below, should be brought before this line

    registerFile #(32)registerFile1(.readRegister1(IR[19:15]), .readRegister2(IR[24:20]), .writeRegister(IR[11:7]), // 4 = log2(N)
    .writeData(writeData),
    .regWrite(RegWrite),
    .clk(clk), .rst(rst),
    .readData1(readData1), .readData2(readData2)
    );
    
    rv32_ImmGen immGen1(.IR(IR), .Imm(immGenOut), .PCout(PCout));
    
//    ALUcu ALUcu1(.ALUop(ALUop), .inst(IR[14:12]), .inst2(IR[30]), .ALUsel(ALUsel));
    ALUcu ALUcu1(.ALUop(ALUop), .funct3(IR[14:12]), .funct7(IR[31:25]), .ALUsel(ALUsel));
    
    NbitMUX #(32)nMUX_ALU(.in0(readData2),
//    .in1({immGenOut[31],immGenOut[31:1]}),
    .in1(immGenOut[31:0]),
    .sel(ALUsrc),
    .out(MUX_ALU));
    
//    ALU ALU1(.sel(ALUsel),
//    .A(readData1), .B(MUX_ALU),
//    .ALUOutput(ALUOutput),
//    .zeroFlag(zeroFlag)
//    );
    wire cf, zf, vf, sf;
    
//    wire [4:0]shamt = ((`OPCODE) == (`OPCODE_Arith_R)) ? readData1[4:0] : (`IR_shamt);
    wire [4:0]shamt = ((IR[6:2]) == (5'b01_100)) ? readData2[4:0] : (IR[24:20]);
    
    prv32_ALU ALU1(
    .a(readData1), .b(MUX_ALU),
	.shamt(shamt),
	.r(ALUOutput),
	.cf(cf), .zf(zf), .vf(vf), .sf(sf),
	.alufn(ALUsel)
    );
    
    DataMem DataMem1(.clk(clk), .MemRead(MemRead), .MemWrite(MemWrite),
    .addr(ALUOutput[7:2]), .data_in(readData2), .data_out(data_out));
 
    NbitMUX #(32)nMUX_RegisterWriteData(.in0(ALUOutput),
    .in1(data_out),
    .sel(MemtoReg),
    .out(MUX_RegisterWriteData));
    
//    NbitShiftLeftOne #(32)NbitShiftLeftOne1(.in(immGenOut), .out(shiftOut));
    
//    assign sumOut = shiftOut + PCout;
    assign sumOut = immGenOut + PCout;
    assign addOut = PCout + 4;
    
    branch_cu branch_cu1(
    .funct3(IR[`IR_funct3]),
    .branch(branch_inst),
    .zf(zf),
    .cf(cf),
    .sf(sf),
    .vf(vf),
    .out(branch) 
    );
    
    NbitMUX #(32)nMUX_PC(.in0(addOut),
    .in1(sumOut),
    .sel(branch || jump),
    .out(MUX_PC));
    
    wire PC_in;
    
//    assign PC_in = jalr ? ALUOutput : MUX_PC;
//    assign PC_in = MUX_PC;
    
//    PC PC1(.in(PC_in), .clk(clk), .rst(rst), .out(PCout));
    PC PC1(.in(jalr ? ALUOutput : MUX_PC), .clk(clk), .rst(rst), .out(PCout));
    
    Four_Digit_Seven_Segment_Driver_Optimized ssd1(.clk(ssdClk), .num(SSD), .Anode(Anode), .LED_out(LED_out));
    

    
    always @(*)begin
    case (ledSel)
        2'b00: LEDs = IR[15:0];
        2'b01: LEDs = IR[31:16];
        2'b10: LEDs = {2'b00, ALUop, ALUsel, zf, branch};
    endcase
    end
    
    
    always @(*)begin
        case(ssdSel)
            4'b0000: SSD = PCout[12:0];
            4'b0001: SSD = addOut[12:0];
            4'b0010: SSD = sumOut[12:0];
            4'b0011: SSD = MUX_PC[12:0];
            4'b0100: SSD = readData1[12:0];
            4'b0101: SSD = readData2[12:0];
            4'b0110: SSD = MUX_RegisterWriteData[12:0];
            4'b0111: SSD = immGenOut[12:0]; // edit to be before shifting
            4'b1000: SSD = immGenOut[12:0];
            4'b1001: SSD = MUX_ALU[12:0];
            4'b1010: SSD = ALUOutput[12:0];
            4'b1011: SSD = data_out[12:0];
            default: SSD = 13'd7999;
        endcase
    end

endmodule
