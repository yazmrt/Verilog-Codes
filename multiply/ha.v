`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2023 10:16:33 PM
// Design Name: 
// Module Name: ha
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


module ha(
input a_i,    // Input 'a'
input b_i,    // Input 'b'
output s_o,   // Output 's' (Sum)
output c_o    // Output 'c' (Carry)
);

assign s_o = a_i ^ b_i;  // Dataflow expression for sum
assign c_o = a_i & b_i;  // Dataflow expression for carry
endmodule
