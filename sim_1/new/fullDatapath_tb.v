`timescale 1ns / 1ps

module fullDatapath_tb(
);

reg clk, ssdClk, rst;
wire [15:0]LEDs;
reg [1:0]ledSel;
wire [6:0]LED_out;
wire [3:0]Anode;
reg [3:0]ssdSel;

fullDatapath DP1(
.clk(clk), .ssdClk(ssdClk), .rst(rst),
.LEDs(LEDs),
.ledSel(ledSel),
.LED_out(LED_out),
.Anode(Anode),
.ssdSel(ssdSel)
);

localparam clk_period = 10;

initial begin
    clk = 1'b0;
    forever begin
    #(clk_period/2);
    clk = ~clk;
    end
end

//initial begin
//    ssdClk = 1'b0;
//    forever begin
//    #(clk_period/2);
//    ssdClk = ~ssdClk;
//    end
//end


initial begin
rst = 1'b1;
#(clk_period/4)
rst = 1'b0;
ledSel = 2'b0;
ssdSel = 4'b0;

#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);
#(clk_period);

$finish;

end
    
endmodule
