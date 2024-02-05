`timescale 1ns / 1ps

module booth_mult(
    input clk,
    input rst,
    input signed [3:0] multiplier_i,
    input signed [3:0] multiplicand_i,
    input start,
    output signed [7:0] result_o
);

localparam IDLE_S = 1'b0;
localparam ACTION_S = 1'b1;

reg [3:0] acc;
reg q_eksi1;
reg state;
reg [2:0] count;
reg [7:0] temp;

initial begin 
    q_eksi1 <= 1'b0;
    count <= 3'b000;
    acc <= 4'b0000;
    temp <= 7'd0;
end

always @(posedge clk) begin
case (state) begin
    IDLE_S: begin
        q_eksi1 <= 1'b0;
        count <= 3'b000;
        acc <= 4'b0000;
        if (start) begin
            temp <= {acc, multiplier_i};
            state <= ACTION_S; 
        end
        else begin
            state <= IDLE_S;
        end
    end
    ACTION_S: begin
        if (temp[0] == q_eksi1) begin
           temp <<< 1;
           q_eksi1 <= temp[0];
        end
        else if ({temp[0], q_eksi1} == 2'b10) begin
            temp <= {temp[7:4]-multiplicand_i,temp[3:0]};
        end
        else if ({temp[0], q_eksi1} == 2'b01) begin
            temp <= {temp[7:4]+multiplicand_i,temp[3:0]};
        end
        count <= count + 1;
        if (count < 3) begin
            state <= ACTION_S;
        end
        else if (count == 3) begin 
            state <= IDLE_S;
        end
    end
    default: IDLE_S;
endcase

end

