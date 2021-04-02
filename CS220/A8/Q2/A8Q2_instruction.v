// Module for Instruction Memory

module memory(prog_counter, instruction);

	reg [31:0] REGISTER[0:10];									// 11 32-bit memory register

	input [7:0] prog_counter; 									// 4 bit program counter as input
	output wire [31:0] instruction;								// 32 bit instruction as output

	initial
		begin
			REGISTER[0]  = 32'b100011_00000_00001_0000000000000000;		// lw $1, 0($0)
			REGISTER[1]  = 32'b100011_00000_00010_0000000000000001;		// lw $2, 1($0)
			REGISTER[2]  = 32'b100011_00000_00011_0000000000000010;		// lw $3, 2($0)
			REGISTER[3]  = 32'b001001_00000_00100_00000_00000000000;	// addiu $4, $0, 0
			REGISTER[4]  = 32'b001001_00001_00101_00000_00000000000;	// addiu $5, $1, 0
			REGISTER[5]  = 32'b000000_00101_00010_00110_00000_101010;   // slt $6, $5, $2
			REGISTER[6]  = 32'b000100_00110_00000_0000000000000101; 	// beq $6, $0, exit
			REGISTER[7]  = 32'b000000_00100_00101_00100_00000_100001; 	// addu $4, $4, $5
			REGISTER[8]  = 32'b000000_00101_00011_00101_00000_100001;	// addu $5, $5, $3
			REGISTER[9]  = 32'b000000_00101_00010_00110_00000_101010;	// slt $6, $5, $2
			REGISTER[10] = 32'b000101_00110_00000_1111111111111101;		// bne $6, $0, loop
		end

	assign instruction = REGISTER[prog_counter];				// Multiplexer to choose the instruction from the program counter

endmodule