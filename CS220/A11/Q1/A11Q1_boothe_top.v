module boothe_multiplier_top;

    reg signed [31:0] a;   // multiplicand
    reg signed [31:0] b;   // multiplier
    reg new_inp;    // new input signal
    reg clk;        // clock

    wire signed [63:0] prod;      // product
    wire done;      // done signal

    boothe_multiplier multiplier(clk, new_inp, a, b, prod, done);

    reg [3:0] counter;

    initial begin
        counter <= 0;
        new_inp <= 0;
    end

    always @(negedge clk) begin
        if(done == 1)
        begin
            $display("time = %d, a = %d, b = %d, a*b = %d", $time, a, b, prod);
        end
    end

    // clock with period 10 time units and 50% duty cycle.
    initial begin
        forever begin
            clk = 0;
            #5 clk = 1;
            #5 clk = 0;
        end
    end

    always @(negedge clk) begin
        if (done == 1) begin
            case (counter)
                0: begin
                    a <= 14;
                    b <= 46;
                end
                1: begin
                    a <= -342;
                    b <= 134;
                end
                2: begin
                    a <= 234;
                    b <= -42;
                end
                3: begin
                    a <= -937;
                    b <= -82;
                end
                4: begin
                    a <= -234124;
                    b <= 0;
                end
                5: begin
                    a <= 0;
                    b <= 63125432;
                end
                6: begin
                    a <= 12345678;
                    b <= 98127492;
                end
                7: begin
                    a <= -23423523;
                    b <= 13408353;
                end
                8: begin
                    a <= 76209185;
                    b <= -432987012;
                end
                9: begin
                    a <= -234223534;
                    b <= -790350888;
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