module FSM_top;
    reg inp, clk;   // input and clock
    wire out;       // output

    FSM uut(inp, out, clk);

    always @(clk) begin
        $display("time = %d, input = %d, output = %d", $time, inp, out);
    end

    initial begin
        #100 $finish;
    end

    // clock with period 10 time units and 50% duty cycle.
    initial begin
        forever begin
            clk = 1;
            #5 clk = 0;
            #5 clk = 1;
        end
    end

    // simulating input stream for 10 clock cycles.
    initial begin
        inp = 0;
        #20 inp = 1;
        #20 inp = 0;
        #20 inp = 0;
        #20 inp = 1;
    end
endmodule