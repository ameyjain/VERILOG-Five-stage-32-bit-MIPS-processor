`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: Amey Ashish Praveen
// 
// Create Date:    12:42:05 03/11/2015 
// Design Name: 
// Module Name:    mips_controller 
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
module mips_controller(
input[5:0] opcode,
output reg reg_dst,
output reg jump,
output reg branch,
output reg mem_rd,
output reg mem_wrt,
output reg [1:0] alu_op,
output reg mem2reg,
output reg alu_src,
output reg reg_write,
output reg and_data2alu,
output reg bne
);


always @(*)
begin
reg_dst=0;
jump = 0;
branch= 0;
mem_rd=0;
mem_wrt=0;
alu_op = 2'b00;
mem2reg= 0;
alu_src=0;
reg_write=0;
and_data2alu=0;
bne=0;

//6'b100011 : begin reg_dst=0; alu_src=0; mem2reg= 0;  reg_write=0; mem_rd=0; mem_wrt=0; branch= 0; alu_op = 2'b00; jump = 0;  end


case (opcode)
6'b000000 : begin reg_dst=1; reg_write=1; alu_op = 2'b10; end //R-format

6'b100011 : begin alu_src=1; mem2reg= 1;  reg_write=1; mem_rd=1; alu_op = 2'b00; end //Load word 

6'b101011 : begin alu_src=1; mem_wrt=1;  alu_op = 2'b00;  end //Store word

6'b000100 : begin branch= 1; alu_op = 2'b01; end //Branch equal

6'b000101: begin bne = 1; alu_op = 2'b01; end //Branch not equal

6'b000010 : begin jump = 1;  end //Jump

6'b001000 : begin reg_dst=0; alu_src=1; mem2reg= 0;  reg_write=1; alu_op = 2'b00; end //ADDI

6'b001100 : begin reg_dst=0; mem2reg= 0;  reg_write=1; alu_op = 2'b10; and_data2alu = 1; end //ANDI

endcase
end   
endmodule
