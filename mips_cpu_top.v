`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:01:08 03/12/2015 
// Design Name: 
// Module Name:    mips_cpu_top 
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
//module mips_cpu_top(

module processor(
input clock, 
input reset,
output[31:0] PC, 
input [31:0] Inst, //Instruction from inst mem
output MemRead,    //Control signals for data memory rd and wrt
output MemWrite,
output [31:0] Addr, //Address line path Data memory read write
output [31:0] Din,  //Data line path to Data memory  
input [31:0] Dout   //dataline recieving path from data memory to register for SW
);


wire w_reg_dst;
wire w_jmp;
wire w_jmp_reg;
wire w_branch;
wire w_mem2reg;
wire w_alu_src;
wire [3:0] w_alu_ctrl;
wire w_reg_write;
wire w_shift_ren;
wire w_shift_len;
wire w_shift_data2reg;
wire w_and_data2alu;
wire [1:0] w_alu_op;
wire w_bne;

//Data Path Instantiation ---------------------------------------------------------
mips_datapath dat_path_inst(

.reg_dst (w_reg_dst),
.jump(w_jmp),
.jr(w_jmp_reg),
.branch(w_branch),
.inst(Inst),
.mem2reg(w_mem2reg),
.alu_src(w_alu_src),
.alu_ctrl(w_alu_ctrl),
.clk(clock),
.reset(reset),
.reg_wrt(w_reg_write),
.mem_data(Dout),
.pc(PC),
.shift_ren(w_shift_ren),
.shift_len(w_shift_len),
.shift_data2reg(w_shift_data2reg),
.and_data2alu(w_and_data2alu),
.data_mem_addr(Addr),
.sw_data(Din),
.bne(w_bne)
);

//-------------------------------------------------------------------



//Controller Instantiation ------------------------------------------
mips_controller ctrl_inst (
.opcode(Inst[31:26]),
.reg_dst(w_reg_dst),
.jump(w_jmp),
.branch(w_branch),
.mem_rd(MemRead),
.mem_wrt(MemWrite),
.alu_op(w_alu_op),
.mem2reg(w_mem2reg),
.alu_src(w_alu_src),
.reg_write(w_reg_write),
.and_data2alu(w_and_data2alu),
.bne(w_bne)
);
//------------------------------------------------------------------

//ALU Control Instantiation-----------------------------------------

alu_ctrl alu_ctrl_inst(
.alu_op(w_alu_op),
.func(Inst[5:0]),
.alu_ctrl(w_alu_ctrl),
.jr(w_jmp_reg),
.shift_ren(w_shift_ren),
.shift_len(w_shift_len),
.shift_data2reg(w_shift_data2reg)
);

//-------------------------------------------------------------------



endmodule
