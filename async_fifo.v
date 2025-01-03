`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2024 02:36:45
// Design Name: 
// Module Name: async_fifo
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

module asyn_fifo(full,empty,rd,
                                 wrt,clk_wrt,clk_rd,reset,rd_en,wrt_en);
input [3:0]wrt;
input clk_wrt,clk_rd,reset,rd_en,wrt_en;

output reg [3:0]rd;
output full,empty;

//
reg [3:0] memory[7:0];
reg [3:0] rd_ptr,wrt_ptr;// 1 extra bit 3 for memory location

//write
always@(posedge clk_wrt)
begin
    if(reset)begin
        wrt_ptr<=0;
    end
    else if(wrt_en && !full)begin
        memory[wrt_ptr[2:0]]<=wrt;
        wrt_ptr<=wrt_ptr+1;
    end
end

//read
always@(posedge clk_rd)
begin
    if(reset)begin
        rd_ptr<=0;
    end
    else if(rd_en && !empty)begin
        rd<=memory[rd_ptr[2:0]];
        rd_ptr<=rd_ptr+1;
    end
end

//full empty => sync.=> CDC 2 fifo sync. => grey code.

//Binary to grey
wire [3:0] b_g_rd,b_g_wrt;
assign b_g_rd=(rd_ptr^(rd_ptr>>1));
assign b_g_wrt=(wrt_ptr^(wrt_ptr>>1));

//Synchronization
reg [3:0]wrt_sync1,wrt_sync2,rd_sync1,rd_sync2;

always@(posedge clk_rd)
begin
    if(reset)begin
        wrt_sync1<=0;
        wrt_sync2<=0;
    end
    else begin
        wrt_sync1<=b_g_wrt;
        wrt_sync2<=wrt_sync1;
    end
end

always@(posedge clk_wrt)
begin
    if(reset)begin
        rd_sync1<=0;
        rd_sync2<=0;
    end
    else begin
        rd_sync1<=b_g_rd;
        rd_sync2<=rd_sync1;
    end
end

//full empty
assign full=(rd_sync2[3]!=wrt_sync2[3] && rd_sync2[2]!=wrt_sync2[2] && rd_sync2[1:0]==wrt_sync2[1:0]);
assign empty=(rd_sync2==wrt_sync2);
endmodule
