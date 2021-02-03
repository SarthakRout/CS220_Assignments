// Top module for rotator

module rotate_top;
    wire [3:0] out; // stores output
    reg clk;        // clock

    M rotate(out, clk);
    always @(out) begin
        $display("time = %d, %b", $time, out);
    end

    initial begin
        #3100000 $finish;   // runs simulation for 310,000 clock cycles.
    end

    initial begin
        forever begin   // implements clock of time period 10 cycles
            clk = 1;    // and duty cycle 50%.
            #5
            clk = 0;
            #5
            clk = 1;
        end
    end
endmodule