// Authored by Mainak Chaudhuri

`include "A6_state_defs.h"

module register_file(clk, current_state, read1Addr, read2Addr, writeAddr, writeValue, read1Valid, read2Valid, writeValid, read1Value, read2Value);

   input clk;
   input [1:0] current_state;
   input [4:0] read1Addr;
   input [4:0] read2Addr;
   input [4:0] writeAddr;
   input [15:0] writeValue;
   input read1Valid;
   input read2Valid;
   input writeValid;
	
   output [15:0] read1Value;
   output [15:0] read2Value;
	
   reg [15:0] read1Value;
   reg [15:0] read2Value;
	
   reg [15:0] regfile [0:31];
	
   initial begin
      regfile[0] = 0;
      regfile[1] = 0;
      regfile[2] = 0;
      regfile[3] = 0;
      regfile[4] = 0;
      regfile[5] = 0;
      regfile[6] = 0;
      regfile[7] = 0;
      regfile[8] = 0;
      regfile[9] = 0;
      regfile[10] = 0;
      regfile[11] = 0;
      regfile[12] = 0;
      regfile[13] = 0;
      regfile[14] = 0;
      regfile[15] = 0;
      regfile[16] = 0;
      regfile[17] = 0;
      regfile[18] = 0;
      regfile[19] = 0;
      regfile[20] = 0;
      regfile[21] = 0;
      regfile[22] = 0;
      regfile[23] = 0;
      regfile[24] = 0;
      regfile[25] = 0;
      regfile[26] = 0;
      regfile[27] = 0;
      regfile[28] = 0;
      regfile[29] = 0;
      regfile[30] = 0;
      regfile[31] = 0;
   end
	
   always @ (posedge clk) begin
      if (current_state == `STATE_RF_RW) begin
         if (read1Valid == 1) begin
            read1Value <= regfile[read1Addr];
         end
         if (read2Valid == 1) begin
            read2Value <= regfile[read2Addr];
         end
         if (writeValid == 1) begin
            regfile[writeAddr] <= writeValue;
         end
      end
      else if (current_state == `STATE_RF_W) begin
         regfile[writeAddr] <= writeValue;
      end
   end

endmodule
