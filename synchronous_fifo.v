`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2024 11:55:12
// Design Name: 
// Module Name: synchronous_fifo
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



module sync_fifo(full,empty,rd,
                                wrt_en,rd_en,clk,rst,wrt);
input wrt_en,rd_en,clk,rst;
input [3:0]wrt;

output reg [3:0]rd;
output full, empty;

//parameter width=4, depth=8;

reg [3:0] memory[7:0];
reg [3:0] rd_ptr,wrt_ptr;

//conditions
assign empty = (rd_ptr[2:0]==wrt_ptr[2:0] && rd_ptr[3]==wrt_ptr[3]);
assign full = (rd_ptr[2:0]==wrt_ptr[2:0] && rd_ptr[3]!=wrt_ptr[3]);

//write
always @(posedge clk)
begin
    if(rst)begin 
        wrt_ptr<=0;
    end
    else if(wrt_en && !full)begin
        memory[wrt_ptr[2:0]]<=wrt;
        wrt_ptr<=wrt_ptr+1;
    end
end

//read
always @(posedge clk)
begin
    if(rst)begin 
        rd_ptr<=0;
        rd<=0;
    end
    else if(rd_en && !empty)begin
        rd<=memory[rd_ptr[2:0]];
        rd_ptr<=rd_ptr+1;
    end
end


endmodule
