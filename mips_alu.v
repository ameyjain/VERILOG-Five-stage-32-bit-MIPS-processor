`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: Amey Ashish Praveen
// 
// Create Date:    01:34:14 03/11/2015 
// Design Name: 
// Module Name:    mips_alu 
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
module mips_alu(
input [3:0] alu_ctrl,
input [31:0]in1,
input [31:0]in2,
output reg [31:0] alu_out,
output zero,
output reg cout
);

assign zero = (alu_out==0);

always @(alu_ctrl, in1, in2)
begin
cout = 0;
	case (alu_ctrl)
	4'd0 : alu_out = in1 & in2;
   4'd1 : alu_out = in1 | in2;
   4'd2 : {cout,alu_out} = in1 + in2;
   4'd6 : alu_out =  in1 - in2;
  	4'd7 : alu_out = (in1 < in2) ? 32'd1 : 32'd0;
	4'd12 : alu_out = ~(in1 | in2);
	default : alu_out = 0;
	endcase
end
endmodule

