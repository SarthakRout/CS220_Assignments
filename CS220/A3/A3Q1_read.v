// Author: Mainak Chaudhuri

`define TICK #2

module dram_read (clk, input_valid, row_number, row, output_valid);

   input clk;
   input input_valid;
   input [3:0] row_number;

   output [31:0] row;
   output output_valid;

   reg [31:0] row;
   reg output_valid;

   reg [31:0] dram [0:15];
   reg [3:0] open_row_number;
   reg open_row_number_valid;
   reg [1:0] delay_counter;

   initial begin
      dram[0] = 0;
      dram[1] = 1;
      dram[2] = 2;
      dram[3] = 3;
      dram[4] = 4;
      dram[5] = 5;
      dram[6] = 6;
      dram[7] = 7;
      dram[8] = 8;
      dram[9] = 9;
      dram[10] = 10;
      dram[11] = 11;
      dram[12] = 12;
      dram[13] = 13;
      dram[14] = 14;
      dram[15] = 15;
      open_row_number_valid = 0;
      output_valid = 0;
   end

   always @ (posedge clk) begin
      if (input_valid) begin
         if (open_row_number_valid) begin
            if (open_row_number == row_number) begin
               row <= `TICK dram[row_number];
               output_valid <= `TICK 1;
               delay_counter <= `TICK 0;
            end
            else begin
               open_row_number <= `TICK row_number;
               output_valid <= `TICK 0;
               delay_counter <= `TICK 2;
            end
         end
         else begin
            open_row_number <= `TICK row_number;
            open_row_number_valid <= `TICK 1;
            output_valid <= `TICK 0;
            delay_counter <= `TICK 1;
         end
      end
      else begin
         if (delay_counter == 1) begin
            row <= `TICK dram[open_row_number];
            output_valid <= `TICK 1;
            delay_counter <= `TICK 0;
         end
         else if (delay_counter == 2) begin
            delay_counter <= `TICK delay_counter - 1;
         end
         else begin
            output_valid <= `TICK 0;
         end
      end
   end

endmodule
