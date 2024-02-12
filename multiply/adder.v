`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2023 08:48:51 PM
// Design Name: 
// Module Name: adder
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
module adder(
input clk,
input [9:0] a_i,
input [9:0] b_i,
input start_i, // starts the addition process
output [9:0] sum_result_o,
output states,
output reg flag
);

wire reg_bit0, reg_bit1;
wire first_carry;
wire fa_in;
reg [1:0] rega_o, regb_o; //shift register outputs

localparam idle = 1'b0;
localparam add = 1'b1;

reg [9:0] rega, regb;
reg [2:0] select;
reg state;
reg dff = 1'b0;
reg [9:0] sum_reg = 0;

// module instantiations
fa fa1(rega_o[0], regb_o[0], dff, reg_bit0, first_carry);
fa fa2(rega_o[1], regb_o[1], first_carry, reg_bit1, fa_in);

assign sum_result_o = sum_reg;
assign states = state;

always @(posedge clk) begin

    dff <= #1 fa_in; 
    case (state)
        idle: begin
            select <= #1 3'b000;
            dff <= #1 0;
            flag = 0;
            if (start_i) begin
               rega <= #1 a_i;
               regb <= #1 b_i;
	           state <= #1 add;
            end
            else begin
                state <= #1 idle;
            end
        end

        add: begin
            sum_reg <= #1 {reg_bit1, reg_bit0, sum_reg[9:2]};
            if (select == 3'b100) begin
                select <= #1 0;
                state <= #1 idle;
                flag = 1;
            end
            else begin
            select <= #1 select + 3'b01;
            state <= #1 add;
            end
        end
        default: state <= #1 idle; 
    endcase
end


always @(*) begin
    if (state == add) begin
    if (select == 3'b000) begin
                rega_o[0] = rega[0];
                rega_o[1] = rega[1];
                regb_o[0] = regb[0];
                regb_o[1] = regb[1];
            end
            else if (select == 3'b001) begin
                rega_o[0] = rega[2];
                rega_o[1] = rega[3];
                regb_o[0] = regb[2];
                regb_o[1] = regb[3];
            end
            else if (select == 3'b010) begin
                rega_o[0] = rega[4];
                rega_o[1] = rega[5];
                regb_o[0] = regb[4];
                regb_o[1] = regb[5];
            end
            else if (select == 3'b011) begin
                rega_o[0] = rega[6];
                rega_o[1] = rega[7];
                regb_o[0] = regb[6];
                regb_o[1] = regb[7];
            end
            else if (select == 3'b100) begin
                rega_o[0] = rega[8];
                rega_o[1] = rega[9];
                regb_o[0] = regb[8];
                regb_o[1] = regb[9];
            end  
            else begin
                rega_o[0] = 0;
                rega_o[1] = 0;
                regb_o[0] = 0;
                regb_o[1] = 0;
            end
    end
    else begin
        rega_o[0] = 0;
        rega_o[1] = 0;
        regb_o[0] = 0;
        regb_o[1] = 0;      
    end
    
end
endmodule


