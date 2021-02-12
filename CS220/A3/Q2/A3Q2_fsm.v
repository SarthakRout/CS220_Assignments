// module for FSM.

module FSM(inp, out, clk);
    // inp recieves input.
    // clk represents tha clock.
    input inp, clk;

    // out stores the required output.
    output reg out;

    // init=1 when FSM just started and init=0 afterwards.
    // seq stores the sequence.
    reg init, seq;

    // initialise the registers.
    initial begin
        init = 1;
        seq = 0;
        out = 1;
    end

    always @(posedge clk) begin
        seq <= inp;
        if (init == 0) begin
            out <= out & (inp ^ seq);
        end
        else begin
            init <= 0;
        end
    end
endmodule