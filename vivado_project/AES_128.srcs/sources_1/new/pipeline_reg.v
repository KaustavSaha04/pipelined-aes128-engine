`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2026 17:00:20
// Design Name: 
// Module Name: pipeline_reg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipeline_reg(
    input [127:0] D,
    input clk, reset,
    output reg [127:0] Q
    );
    
    always@(posedge clk) begin  //synch reset
    if(reset)
        Q <= 0;
    else
        Q <= D;
    end
endmodule
