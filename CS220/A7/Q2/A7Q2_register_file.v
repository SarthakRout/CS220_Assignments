// Module for Register File
module register_file(clk, valid, read_addr_1, read_addr_2, write_addr, write_data, read_1, read_2);

input clk;										// Clock
input [2:0] valid;        						// Indicator for which read/write operation to perform
input [4:0] read_addr_1;						// 5 bit 1st source register address
input [4:0] read_addr_2;						// 5 bit 2nd source register address
input [4:0] write_addr;							// 5 bit destination register address
input [7:0] write_data;							// 8 bit data to write in a register
output reg [7:0] read_1;						// 8 bit data read from the 1st register
output reg [7:0] read_2;						// 8 bit data read from the 2nd register

reg [7:0] REGISTER[0:31]; 						//32 8-bit register file

wire read_valid_1,read_valid_2,write_valid;
assign write_valid = valid[2];
assign read_valid_1 = valid[1];
assign read_valid_2 = valid[0];

initial											// Initialisation of register file
	begin
		REGISTER[0] = 8'b0; 
		REGISTER[1] = 8'b0; 
		REGISTER[2] = 8'b0; 
		REGISTER[3] = 8'b0; 
		REGISTER[4] = 8'b0; 
		REGISTER[5] = 8'b0; 
		REGISTER[6] = 8'b0; 
		REGISTER[7] = 8'b0; 
		REGISTER[8] = 8'b0; 
		REGISTER[9] = 8'b0; 
		REGISTER[10] = 8'b0; 
		REGISTER[11] = 8'b0; 
		REGISTER[12] = 8'b0; 
		REGISTER[13] = 8'b0; 
		REGISTER[14] = 8'b0; 
		REGISTER[15] = 8'b0; 
		REGISTER[8] = 8'b0; 
		REGISTER[17] = 8'b0; 
		REGISTER[18] = 8'b0; 
		REGISTER[19] = 8'b0; 
		REGISTER[20] = 8'b0; 
		REGISTER[21] = 8'b0; 
		REGISTER[22] = 8'b0; 
		REGISTER[23] = 8'b0; 
		REGISTER[24] = 8'b0; 
		REGISTER[25] = 8'b0; 
		REGISTER[26] = 8'b0; 
		REGISTER[27] = 8'b0; 
		REGISTER[28] = 8'b0; 
		REGISTER[29] = 8'b0; 
		REGISTER[30] = 8'b0; 
		REGISTER[31] = 8'b0; 
	end

	always @(posedge clk)
		begin
			if(write_valid == 1) begin
				REGISTER[write_addr] <= write_data;
			end
			if(read_valid_1 == 1) begin
				read_1 <= REGISTER[read_addr_1];
			end
			if(read_valid_2 == 1) begin
				read_2 <= REGISTER[read_addr_2];
			end
		end

endmodule