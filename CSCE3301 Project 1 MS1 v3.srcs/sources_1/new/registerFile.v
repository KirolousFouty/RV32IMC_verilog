`timescale 1ns / 1ps

module registerFile #(parameter N = 32)(
input [4:0]readRegister1, readRegister2, writeRegister, // 4 = log2(N)
input [N-1:0]writeData,
input regWrite,
input clk, rst,
output wire [N-1:0]readData1, readData2
);

reg [N-1:0]NbitRegisterWire[N-1:0];
integer i;


always @(posedge clk or posedge rst)begin
    if (rst == 1'b1)
        begin
        for (i = 0; i < N; i=i+1)
            begin
            NbitRegisterWire[i]<=32'd0;
            end
        end
    else
        begin
        if (regWrite == 1'b1 && writeRegister != 5'b0)
        NbitRegisterWire[writeRegister] = writeData;
    end
end

assign readData1 = NbitRegisterWire[readRegister1];
assign readData2 = NbitRegisterWire[readRegister2];
    
endmodule
