`timescale 1ns / 1ps
`include "defines.v"

module branch_cu(
    input [2:0] funct3,
    input branch,
    input zf,
    input cf,
    input sf,
    input vf,
    output reg out 
);
    always @(*) begin
        if (branch)
            begin
            case (funct3)
                `BR_BEQ     :       out = zf;
                `BR_BNE     :       out = ~zf;
                `BR_BLT     :       out = (sf != vf);
                `BR_BGE     :       out = (sf == vf);
                `BR_BLTU    :       out = ~cf;
                `BR_BGEU    :       out = cf; 
                default     :       out = 1'b0;
            endcase
            end
        else
        out = 1'b0;
    end

endmodule
