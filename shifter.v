`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: Amey Ashish Praveen
// 
// Create Date:    22:17:47 03/11/2015 
// Design Name: 
// Module Name:    shifter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module shifter(
input [31:0] datain,
input [4:0] shftamt,
output reg[31:0] data_out,
input shift_len,
input shift_ren
);


always @(*)
begin
data_out = 32'd0;
if(shift_ren)
data_out = datain >> shftamt;
if(shift_len)
data_out = datain << shftamt;
end

endmodule
