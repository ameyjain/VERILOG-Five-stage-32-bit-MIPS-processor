`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: Amey Ashish Praveen
// 
// Create Date:    02:30:15 03/11/2015 
// Design Name: 
// Module Name:    mips_datapath 
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
module mips_datapath(
input reg_dst,
input jump,
input jr,
input branch,
input bne,
//input mem_rd,
//input mem_wrt,
input [31:0] inst,
input mem2reg,
input alu_src,
input [3:0] alu_ctrl,
input clk,
input reset,
input reg_wrt,


input [31:0] mem_data,
output reg [31:0] pc,

input shift_ren,
input shift_len,
input shift_data2reg,

input and_data2alu,
output [31:0] data_mem_addr,
output [31:0] sw_data
);



wire [31:0] rd_dat1,rd_dat2;
wire [31:0] alu_data;
wire alu_zero;

wire [31:0] pc_d;
wire [4:0] write_addr;
wire [31:0] alu_in2;
wire [31:0] reg_data;
wire brnch_qualify;
wire bne_qualify;
wire [31:0] inc_pc_by4;
wire [31:0] bta;
wire [31:0] bta_or_inc_pc;
wire [31:0] pc_nxt;
wire [31:0] jmp_addr;
wire [31:0] mem_or_alu;
wire [31:0] sigext_or_reg_data;
wire [31:0] shift_dataout;





reg_file u1_reg_file (   
            .rd_addr1(inst[25:21]),
            .rd_addr2(inst[20:16]),
            .wrt_addr(write_addr),
            .wrt_data(reg_data),
            .wrt_ctrl(reg_wrt),
            .rd_data1(rd_dat1),
            .rd_data2(rd_dat2), 
            .clk(clk),
            .rst(reset)				
		     );

mips_alu u2_alu (
                .alu_ctrl(alu_ctrl),
                .in1(rd_dat1),
                .in2(alu_in2),
                .alu_out(alu_data),
                .zero(alu_zero),
                .cout()
);



shifter u3_shifter (
                 .datain(rd_dat2),
                 .shftamt(inst[10:6]),
                 .data_out(shift_dataout),
                 .shift_ren(shift_ren),
                 .shift_len(shift_len)
);






always @(posedge clk or posedge reset)
begin
	if(reset)
	pc <= 32'd0;
	else
	pc <= pc_nxt;
end



assign write_addr = (reg_dst) ? inst[15:11] : inst[20:16];

assign sigext_or_reg_data = (alu_src) ? ({{16{inst[15]}},inst[15:0]}) : rd_dat2;

assign mem_or_alu = (mem2reg) ? mem_data : alu_data;

assign brnch_qualify = alu_zero & branch;
assign bne_qualify  = ~alu_zero & bne;

assign inc_pc_by4 = pc + 32'd4;

assign bta = inc_pc_by4 + (({{16{inst[15]}},inst[15:0]}) << 2) ;

assign bta_or_inc_pc = (brnch_qualify) ? bta : inc_pc_by4;

assign pc_d = jump ? {inc_pc_by4[31:28],{inst[25:0] << 2}} :  bta_or_inc_pc;

assign jmp_addr = jr ? rd_dat1 : pc_d;

assign reg_data = shift_data2reg ? shift_dataout : mem_or_alu;

assign alu_in2 = (and_data2alu) ? ({{16{1'b0}},inst[15:0]}) : sigext_or_reg_data;

assign data_mem_addr = alu_data;

assign sw_data = rd_dat2;

assign pc_nxt = bne_qualify ? bta : jmp_addr;


endmodule
