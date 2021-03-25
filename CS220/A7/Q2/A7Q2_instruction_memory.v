// Module for Instruction Memory

module memory(ip, instruction);

	reg [31:0] REGISTER[0:6];									// 8 32-bit memory register

	input [2:0] ip; 									// 3 bit program counter as input
	output wire [31:0] instruction;								// 32 bit instruction as output

	initial
		begin
			REGISTER[0] = 32'b00100100000000010000000000101101;	// addiu $1, $0, 45
			REGISTER[1] = 32'b00100100000000101111111111101100;	// addiu $2, $0, -20
			REGISTER[2] = 32'b00100100000000111111111111000100;	// addiu $3, $0, -60
			REGISTER[3] = 32'b00100100000001000000000000011110;	// addiu $4, $0, 30
			REGISTER[4] = 32'b0000000001000100010100000010101;	// addu $5, $1, $2
			REGISTER[5] = 32'b0000000011001000011000000010101; // addu $6, $3, $4
			REGISTER[6] = 32'b0000000101001100010100000010111; // subu $5, $5, $6
		end

	assign instruction = REGISTER[ip];				// Multiplexer to choose the instruction from the program counter

endmodule