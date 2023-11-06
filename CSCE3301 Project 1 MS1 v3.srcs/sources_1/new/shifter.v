
module shifter(
input wire signed [31:0] in,
input [4:0] shamt,
input [1:0] sel,
output reg [31:0] out
);

always@ (*) begin

       case (sel)
        2'b00 : out =  in >> shamt; // SRLI
        2'b01 : out = in << shamt;  // SLLI
        2'b10 : out = in >>> shamt; // SRAI
       endcase
    end

endmodule
