// Module for Register File

module register_file(clk, valid, read_addr_1, read_addr_2, write_addr, write_data, read_1, read_2);

input clk;
input [3:0] valid;
input [4:0] read_addr_1;
input [4:0] read_addr_2;
input [4:0] write_addr_1;
input [15:0] write_data;
output reg [15:0] read_1;
output reg [15:0] read_2;

reg [15:0] REGISTER[0:31];
reg done;

initial
	begin
		done = 1'b0;
		REGISTER[0] = 16'b0; 
		REGISTER[1] = 16'b0; 
		REGISTER[2] = 16'b0; 
		REGISTER[3] = 16'b0; 
		REGISTER[4] = 16'b0; 
		REGISTER[5] = 16'b0; 
		REGISTER[6] = 16'b0; 
		REGISTER[7] = 16'b0; 
		REGISTER[8] = 16'b0; 
		REGISTER[9] = 16'b0; 
		REGISTER[10] = 16'b0; 
		REGISTER[11] = 16'b0; 
		REGISTER[12] = 16'b0; 
		REGISTER[13] = 16'b0; 
		REGISTER[14] = 16'b0; 
		REGISTER[15] = 16'b0; 
		REGISTER[16] = 16'b0; 
		REGISTER[17] = 16'b0; 
		REGISTER[18] = 16'b0; 
		REGISTER[19] = 16'b0; 
		REGISTER[20] = 16'b0; 
		REGISTER[21] = 16'b0; 
		REGISTER[22] = 16'b0; 
		REGISTER[23] = 16'b0; 
		REGISTER[24] = 16'b0; 
		REGISTER[25] = 16'b0; 
		REGISTER[26] = 16'b0; 
		REGISTER[27] = 16'b0; 
		REGISTER[28] = 16'b0; 
		REGISTER[29] = 16'b0; 
		REGISTER[30] = 16'b0; 
		REGISTER[31] = 16'b0; 
	end

	always @(posedge clk)
		begin
			if (! valid[0])
				begin
					// Should this be independent?
					read_1 <= #20 REGISTER[read_addr_1]; 
				end
			if (! valid[1])
				begin
					read_2 <= #20 REGISTER[read_addr_2];
				end
			if (! valid[2])
				begin
					REGISTER[write_addr] <= #20 write_data;
				end
		end

endmodule