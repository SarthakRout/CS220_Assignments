// Top module for processor

module processor_top;

    reg clk; 								// Register for Clock with period 10 and 50% duty cycle
    reg [2:0] instr;						// 3 bit instruction code
    reg [4:0] reg1, reg2, reg3;				// 3 5-bit registers to storing address of operands
    reg [15:0] const;						// 16 bit register for passing constants for immediate operands
    wire done;								// Wire signalling whether the processor can pass the next instruction
    reg [3:0] ip;							// 4 bit register "ip" which counts the number of instructions executed

    processor p(clk, instr, reg1, reg2, reg3, const, done);

    initial begin							// Initialisation of registers
        ip = 0;
        instr = 0;
        reg1 = 0;
        reg2 = 0;
        reg3 = 0;
        const = 0;
    end

    initial begin							// Implementing clock
        forever begin
            clk = 0;
            #5 clk = 1;
            #5 clk = 0;
        end
    end

    always @(posedge clk) begin
        if(done == 1'b1) begin
            if(ip == 0) begin				// First instruction 000 $1 17
                instr <= 3'b000;
                reg1 <= 0;
                reg2 <= 0;
                reg3 <= 1;
                const <= 17;
            end
            if(ip == 1) begin 				// Second instruction 011 $1 $2 -9
                instr <= 3'b011;
                reg1 <= 1;
                reg2 <= 0;
                reg3 <= 2;
                const <= -9;
            end
            if(ip == 2) begin				// Third instruction 100 $1 $2 $3 65
                instr <= 3'b100;
                reg1 <= 1;
                reg2 <= 2;
                reg3 <= 3;
                const <= 65;
            end
            if(ip == 3) begin				// Fourth instruction 010 $2 $3
                instr <= 3'b010;
                reg1 <= 2;
                reg2 <= 3;
                reg3 <= 0;
                const <= 0;
            end
            if(ip == 4) begin				// Fifth instruction 111 $3 $5 3
                instr <= 3'b111;
                reg1 <= 3;
                reg2 <= 0;
                reg3 <= 5;
                const <= 3;
            end
            if(ip == 5) begin				// Sixth instruction 101 $1 $2 $4
                instr <= 3'b101;
                reg1 <= 1;
                reg2 <= 2;
                reg3 <= 4;
                const <= 0;
            end
            if(ip == 6) begin				// Seventh instruction 111 $4 $4 9
                instr <= 3'b111;
                reg1 <= 4;
                reg2 <= 0;
                reg3 <= 4;
                const <= 9;
            end
            if(ip == 7) begin				// Eighth instruction 110 $5 $4 $6
                instr <= 3'b110;
                reg1 <= 5;
                reg2 <= 4;
                reg3 <= 6;
                const <= 0;
            end
            if(ip == 8) begin				// Ninth instruction 001 $6
                instr <= 3'b001;
                reg1 <= 6;
                reg2 <= 0;
                reg3 <= 0;
                const <= 0;
            end

            if(ip == 9) begin
                $finish;
            end
            
            ip <= ip+1;
        end
    end

endmodule