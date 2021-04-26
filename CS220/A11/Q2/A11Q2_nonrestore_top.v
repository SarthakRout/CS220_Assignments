// Top Module for Non-Restoring Division Algorithm

module top;

 	reg [31:0] a;   		// 32-bit unsigned dividend
 	reg [4:0] len_a;		// length of dividend
    reg [31:0] b;   		// 32-bit unsigned divisor
    reg [4:0] len_b;		// length of divisor
    reg new_inp;    		// new input signal
    reg clk;        		// clock

    wire [31:0] quotient;   // 32-bit unsigned quotient 
    wire [31:0] remainder;  // 32-bit unsigned remainder
    wire [4:0] count_add;	// counts number of additions
    wire [4:0] count_sub;	// counts number of subtractions
    wire done;      		// done signal
	
	divide divider(clk, new_inp, a, len_a, b, len_b, quotient, remainder, count_add, count_sub, done);

	reg [3:0] counter; 		// 4 bit counter

	always @(negedge clk) begin
        if(done == 1)
        begin
            $display("time = %4d, a = %d, b = %d, quotient = %d, remainder = %d, counts: add = %d, sub = %d\n", $time, a, b, quotient, remainder, count_add, count_sub);
        end
    end

    // clock with period 10 time units and 50% duty cycle.
    initial begin
    	counter = 0;
        forever begin
            clk = 1;
            #5 clk = 0;
            #5 clk = 1;
        end
    end

     always @(negedge clk) begin
        if (done == 1) begin
            case (counter)
                0: begin
                    a <= 10;
                    b <= 5;
                    len_a <= 4;
                    len_b <= 3;
                end
                1: begin
                    a <= 8;
                    b <= 1;
                    len_a <= 4;
                    len_b <= 1;
                end
                2: begin
                    a <= 234;
                    b <= 42;
                    len_a <= 8;
                    len_b <= 6;
                end
                3: begin
                    a <= 937;
                    b <= 82;
                    len_a <= 10;
                    len_b <= 7;
                end
                4: begin
                    a <= 8;
                    b <= 10;
                    len_a <= 4;
                    len_b <= 4;
                end
                5: begin
                    a <= 0;
                    b <= 40240;
                    len_a <= 1;
                    len_b <= 16;
                end
                6: begin
                    a <= 12345678;
                    b <= 98127492;
                    len_a <= 24;
                    len_b <= 27;
                end
                7: begin
                    a <= 958265;
                    b <= 13408353;
                    len_a <= 20;
                    len_b <= 24;
                end
                8: begin
                    a <= 76209185;
                    b <= 154222;
                    len_a <= 27;
                    len_b <= 18;
                end
                9: begin
                    a <= 234223534;
                    b <= 790350888;
                    len_a <= 28;
                    len_b <= 30;
                end
                10: begin
                	a <= 0;
                	b <= 0;
                	len_a <= 1;
                	len_b <= 1;
                end
                11: begin
                    a <= 10;
                    b <= 0;
                    len_a <= 4;
                    len_b <= 1;
                end
                default: $finish;
            endcase
            new_inp <= 1;
            counter <= counter + 1;
        end
        else begin
            new_inp <= 0;
        end
    end

endmodule