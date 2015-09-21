`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: Amey Ashish Praveen
// 
// Create Date:    13:05:27 03/11/2015 
// Design Name: 
// Module Name:    alu_ctrl 
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
module alu_ctrl(
input [1:0] alu_op,
input [5:0] func,
output reg [3:0] alu_ctrl,
output reg jr,
output reg shift_ren,
output reg shift_len,
output reg shift_data2reg
);


always @(*)
begin
alu_ctrl = 4'b0000;
jr = 1'b0;
shift_ren = 0;
shift_len = 0;
shift_data2reg = 0;

if(alu_op == 2'b00)
alu_ctrl = 4'b0010; // load_word or store word
if(alu_op == 2'b01)
alu_ctrl = 4'b0110; // branch equal

if(alu_op == 2'b10 )
begin
   case(func)
	6'b100000 : alu_ctrl = 4'b0010; // ADD
	6'b100010 : alu_ctrl = 4'b0110; // SUB
	6'b100100 : alu_ctrl = 4'b0000; //AND
	6'b100101 : alu_ctrl = 4'b0001; //OR
	6'b101010 : alu_ctrl = 4'b0111; //SLT
	6'b001000 : jr = 1'b1;
	6'b000000 : begin shift_len = 1; shift_data2reg = 1; end
	6'b000010 : begin shift_ren = 1; shift_data2reg = 1; end
	endcase
end
end
 
endmodule

