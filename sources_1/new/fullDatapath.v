`timescale 1ns / 1ps

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
    wire [31:0] instruction;
    
    wire branch, MemRead, MemtoReg;
    wire [1:0]ALUop;
    wire MemWrite, ALUsrc, RegWrite;

    wire [N-1:0]writeData; // todo: check writeData in RegisterFile
    wire [N-1:0]readData1, readData2;

    wire [31:0] immGenOut;

    wire [3:0]ALUsel;
    
    wire [31:0]MUX_ALU;
    
    wire [N-1:0]ALUOutput;
    wire zeroFlag;
    
    wire [31:0] data_out;
    
    wire [31:0] MUX_RegisterWriteData;
    
    wire [N-1:0]shiftOut;
    
    wire [31:0]sumOut;
    wire [31:0]PCout;
    
    wire [31:0]MUX_PC;
    
    wire [31:0]addOut;
    
    reg [12:0]SSD;
    
    InstMem InstMem1(.addr(PCout[7:2]), .data_out(instruction));
    
    CU CU1(.inst(instruction[6:2]), 
    .branch(branch), .MemRead(MemRead), .MemtoReg(MemtoReg), 
    .ALUop(ALUop), 
    .MemWrite(MemWrite), .ALUsrc(ALUsrc), .RegWrite(RegWrite));

    registerFile #(32)registerFile1(.readRegister1(instruction[19:15]), .readRegister2(instruction[24:20]), .writeRegister(instruction[11:7]), // 4 = log2(N)
    .writeData(MUX_RegisterWriteData),
    .regWrite(RegWrite),
    .clk(clk), .rst(rst),
    .readData1(readData1), .readData2(readData2));
    
    immGen immGen1(.in(instruction), .out(immGenOut));
    
    ALUcu ALUcu1(.ALUop(ALUop), .inst(instruction[14:12]), .inst2(instruction[30]), .ALUsel(ALUsel));
    
    NbitMUX #(32)NbitMUX1(.in0(readData2),
    .in1(immGenOut),
    .sel(ALUsrc),
    .out(MUX_ALU));
    
    ALU ALU1(.sel(ALUsel),
    .A(readData1), .B(MUX_ALU),
    .ALUOutput(ALUOutput),
    .zeroFlag(zeroFlag)
    );
    
    DataMem DataMem1(.clk(clk), .MemRead(MemRead), .MemWrite(MemWrite),
    .addr(ALUOutput[7:2]), .data_in(readData2), .data_out(data_out));
 
    NbitMUX #(32)NbitMUX2(.in0(ALUOutput),
    .in1(data_out),
    .sel(MemtoReg),
    .out(MUX_RegisterWriteData));
    
    
    NbitShiftLeftOne #(32)NbitShiftLeftOne1(.in(immGenOut),
    .out(shiftOut));
    
    assign sumOut = shiftOut + PCout;
    assign addOut = PCout + 4;
    
    NbitMUX #(32)NbitMUX3(.in0(addOut),
    .in1(sumOut),
    .sel(branch & zeroFlag),
    .out(MUX_PC));
    
    
    PC PC1(.in(MUX_PC), .clk(clk), .rst(rst), .out(PCout));
    
    Four_Digit_Seven_Segment_Driver_Optimized ssd1(.clk(ssdClk), .num(SSD), .Anode(Anode), .LED_out(LED_out));
    
    
    always @(*)begin
    case (ledSel)
        2'b00: LEDs = instruction[15:0];
        2'b01: LEDs = instruction[31:16];
        2'b10: LEDs = {2'b00, ALUop, ALUsel, zeroFlag, (branch & zeroFlag)};
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
            4'b0111: SSD = immGenOut[12:0];
            4'b1000: SSD = shiftOut[12:0];
            4'b1001: SSD = MUX_ALU[12:0];
            4'b1010: SSD = ALUOutput[12:0];
            4'b1011: SSD = data_out[12:0];
            default: SSD = 13'b11111111111 ;
        endcase
    end

endmodule
