`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2023 11:01:30 PM
// Design Name: 
// Module Name: top_module
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

module top_module(
input rst,
input clk,
input [9:0] A_i,
input [9:0] B_i,
output [19:0] res_o);

//states
localparam idle = 1'b0, shift_and_compress = 1'b1;
reg state;

//compressor arguments
wire [9:0] inl0_next; //output wire of the compressor
wire [13:0] inl1_next; //output wire of the compressor
reg [8:0] inpp0; //new input of compressor
reg [10:0] inpp1; //new input of compressor
reg [9:0] inl0; //previous output looped input
reg [11:0] inl1; // previous output looped input

//adder arguments
reg [9:0] adder_reg0; //adder input
reg [9:0] adder_reg1; //adder input
reg start_reg; //start signal of adder
wire adder_states;
wire add_flag;

//result registers
reg [8:0] temp_reg = 9'b0;
reg [9:0] temp_reg1 = 10'b0;
reg [9:0] temp_reg2 = 10'b0;
reg [8:0] result0 = 9'b0; //result 
reg [10:0] result1;
wire [9:0] adder_result;


reg [1:0] two_bit_reg; //register for partial products
reg [2:0] count; //for pipelining the result


reg [2:0] select; //for shifting with multiplexers.

// module instantiations
compr Compressor(.inpp0(inpp0),.inpp1(inpp1),.inl0(inl0),.inl1(inl1),.out0(inl0_next),.out1(inl1_next));
adder Adder(.clk(clk),.a_i(adder_reg0),.b_i(adder_reg1),.start_i(start_reg),.sum_result_o(adder_result[9:0]),.states(adder_states), .flag(add_flag));

always @(posedge clk) begin 

if (add_flag == 1) begin
    result1[9:0] <= #1 adder_result;
    end
    
//rst starts the multiplication
if (rst) begin
    inl0 <= #1 10'b0000000000;
    inl1 <= #1 12'b00000000000;
    state <= #1 shift_and_compress;
    start_reg <= #1 1'b0;
    count <= #1 0;
    select <= #1 3'b000;
end
else begin    
    case(state)
    //waiting for operands and starting of the multiplication
        idle: begin
                if (count == 5) begin
                count <= #1 0;
                result0 <= #1 temp_reg1[8:0];
                result1[10] <= #1 temp_reg1[9];
                end
                count <= #1 count + 1;
                select <= #1 3'b000;
                start_reg <= #1 1'b0;
                state <= #1 idle;
            end
        //All the process done in this state
        shift_and_compress: begin
            if (select == 3'b100) begin
                temp_reg1[9] <= #1 inl1[11];
                temp_reg1[8:0] <= #1 {inl1_next[2:0],temp_reg[8:3]};
                result0 <= #1 temp_reg1[8:0];
                result1[10] <= #1 temp_reg1[9];
                adder_reg0 <= #1 inl0_next;
                adder_reg1 <= #1 inl1_next[12:3];
                start_reg <= #1 1'b1;   
                state <= #1 idle;
            end
            else begin
                temp_reg <= #1 {inl1[1:0],temp_reg[8:2]};
                inl0 <= #1 inl0_next;
                inl1 <= #1 inl1_next[13:2];
                select <= #1 select + 3'b001;
                state <= #1 shift_and_compress;
            end
        end
        default: state <= #1 idle;
endcase
end
end

//generation of partial products
always @(*) begin

if (state == shift_and_compress) begin
    if (select == 3'b000) begin
        two_bit_reg[0] = B_i[0];
        two_bit_reg[1] = B_i[1];
    end
    else if (select == 3'b001) begin
        two_bit_reg[0] = B_i[2];
        two_bit_reg[1] = B_i[3];
    end
    else if (select == 3'b010) begin
        two_bit_reg[0] = B_i[4];
        two_bit_reg[1] = B_i[5];
    end
    else if (select == 3'b011) begin
        two_bit_reg[0] = B_i[6];
        two_bit_reg[1] = B_i[7];
    end
    else if (select == 3'b100) begin
        two_bit_reg[0] = B_i[8];
        two_bit_reg[1] = B_i[9];
    end  
    else begin
        two_bit_reg[0] = 0;
        two_bit_reg[1] = 0;
    end
        if (two_bit_reg[0] == 1'b1) begin
            inpp0 = A_i[9:1];   
            if (two_bit_reg[1] == 1) begin
                inpp1 = {A_i, A_i[0]};
            end
            else begin
                inpp1 = {10'b0, A_i[0]};
            end
        end
        else begin
            inpp0 = 0;
            if (two_bit_reg[1] == 1) begin
                inpp1 = {A_i, 1'b0};
            end
            else begin
                inpp1 = 0;
            end
         end
    
 end
 else begin
    inpp0 = 0;
    inpp1 = 0;
 end
 end
 
//assigning the result
assign res_o = {result1, result0};

endmodule
