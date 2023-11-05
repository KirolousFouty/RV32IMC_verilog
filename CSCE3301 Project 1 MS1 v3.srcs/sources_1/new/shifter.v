
module shifter(
input wire signed [31:0] a,
input [4:0] shamt,
input [1:0] type,
output reg [31:0] r
);

always@ (*) begin

       case (type)
        2'b00 : r =  a >> shamt; // SRLI
        2'b01 : r = a << shamt;  // SLLI
        2'b10 : r = a >>> shamt; // SRAI
       endcase
    end

endmodule
