// Module for Instruction Memory

module memory(prog_counter, instruction);

	reg [31:0] REGISTER[0:13];									// 14 32-bit memory register

	input [7:0] prog_counter; 									// 4 bit program counter as input
	output wire [31:0] instruction;								// 32 bit instruction as output

	initial
		begin
			REGISTER[0]  = 32'b001001_00000_00010_00000_00000000000;	// addiu $2, $0, 0 
			REGISTER[1]  = 32'b001001_00000_00011_00000_00000000000;	// addiu $3, $0, 0
			REGISTER[2]  = 32'b000000_00011_00001_00100_00000_101010;	// slt $4, $3, $1
			REGISTER[3]  = 32'b000100_00100_00000_0000000000001000;	   	// beq $4, $0, exit
			REGISTER[4]  = 32'b001001_00000_00101_00000_00000001010;	// addiu $5, $0, 10
			REGISTER[5]  = 32'b000100_00011_00101_0000000000000110;  	// beq $3, $5, exit
			REGISTER[6]  = 32'b100011_00011_00110_0000000000000000; 	// lw $6, 0($3)
			REGISTER[7]  = 32'b000000_00010_00110_00010_00000_100001; 	// addu $2, $2, $6
			REGISTER[8]  = 32'b001001_00011_00011_00000_00000000001;	// addiu $3, $3, 1
			REGISTER[9]  = 32'b000000_00011_00001_00100_00000_101010;	// slt $4, $3, $1
			REGISTER[10] = 32'b000101_00100_00000_1111111111111011;		// bne $4, $0, loop
			REGISTER[11] = 32'b000000_11111_00000_00000_00000_001000;	// jr $31
			REGISTER[12] = 32'b100011_00000_00001_0000000000001010;		// lw $1, 10($0)
			REGISTER[13] = 32'b000011_00000000000000000000000000; 		// jal Sum
		end

	assign instruction = REGISTER[prog_counter];				// Multiplexer to choose the instruction from the program counter

endmodule