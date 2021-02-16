// top module for testing eight bit adder/subtracter.
module eight_bit_adder_subtracter_top;
    reg signed [7:0] a, b;  // signed 8-bit operands
    reg opcode;             // operation code
    wire signed [7:0] sum;  // output of operation
    wire overflow, carry;   // stores overflow and carry

    eight_bit_adder_subtracter uut(a, b, opcode, sum, carry, overflow);

    always @(a or b or sum or opcode or overflow or carry) begin
        if(opcode==0)   // display operation as + if opcode = 0 otherwise as -.
            $display("time = %d, %d + %d = %d, overflow: %d, carry: %d", $time, a, b, sum, overflow, carry);
        else

            $display("time = %d, %d - %d = %d, overflow: %d, carry: %d", $time, a, b, sum, overflow, carry);
    end

    // total time of testing = 10 units
    initial begin
        #10 $finish;
    end

    initial begin
        // 10 test cases with gap of 1 time unit b/w consecutive tests.
        a = 23; b = 45; opcode = 0;
        #1
        $display("\n");
        a = 120; b = 20; opcode = 0;
        #1
        $display("\n");
        a = 14; b = -114; opcode = 0;
        #1
        $display("\n");
        a = 23; b = 78; opcode = 1;
        #1
        $display("\n");
        a = -120; b = -127; opcode = 1;
        #1
        $display("\n");
        a = 120; b = -127; opcode = 1;
        #1
        $display("\n");
        a = -68; b = -68; opcode = 0;
        #1
        $display("\n");
        a = -127; b = 48; opcode = 0;
        #1
        $display("\n");
        a = -80; b = 99; opcode = 1;
        #1
        $display("\n");
        a = 5; b = 5; opcode = 1;
    end

endmodule