`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: Amey Ashish Praveen
// 
// Create Date:    01:57:42 03/11/2015 
// Design Name: 
// Module Name:    reg_file 
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
module reg_file(
input [4:0] rd_addr1,
input [4:0] rd_addr2,
input [4:0] wrt_addr,
input [31:0] wrt_data,
input wrt_ctrl,
output [31:0] rd_data1,
output [31:0] rd_data2,
input clk,
input rst
);

reg [31:0] reg_blk [0:31];

assign rd_data1 = reg_blk[rd_addr1];
assign rd_data2 = reg_blk[rd_addr2];

always @(posedge clk or posedge rst)
begin
   if (rst) begin
      reg_blk[0]  <= 32'h0;reg_blk[1]  <= 32'h00000000;reg_blk[2]  <= 32'h00000000;       
      reg_blk[3]  <= 32'h00000000;    reg_blk[4]  <= 32'h00000000;       
      reg_blk[5]  <= 32'h00000000;       
      reg_blk[6]  <= 32'h00000000;       
      reg_blk[7]  <= 32'h00000000;       
      reg_blk[8]  <= 32'h00000000;       
      reg_blk[9]  <= 32'h00000000;       
      reg_blk[10] <= 32'h00000000;       
      reg_blk[11] <= 32'h00000000;       
      reg_blk[12] <= 32'h00000000;       
      reg_blk[13] <= 32'h00000000;       
      reg_blk[14] <= 32'h00000000;       
      reg_blk[15] <= 32'h00000000;       
      reg_blk[16] <= 32'h00000000;      
      reg_blk[17] <= 32'h0;       
      reg_blk[18] <= 32'h0;       
      reg_blk[19] <= 32'h0;       
      reg_blk[20] <= 32'h0;       
      reg_blk[21] <= 32'h0;      
      reg_blk[22] <= 32'h0;
      reg_blk[23] <= 32'h0;
		reg_blk[24] <= 32'h0;
      reg_blk[25] <= 32'h0;
		reg_blk[26] <= 32'h0;
      reg_blk[27] <= 32'h0;
		reg_blk[28] <= 32'h0;
      reg_blk[29] <= 32'h0;
		reg_blk[30] <= 32'h0;
      reg_blk[31] <= 32'h0;
end

else if(wrt_ctrl)
reg_blk[wrt_addr] <= wrt_data;
end


endmodule
