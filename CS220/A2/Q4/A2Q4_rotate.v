// module for rotating signal.

module M(out, clk);
    input clk;
    output reg [3:0] out;
    reg [20:0] counter;

    initial begin 
        out = 4'b1000;  // contains final output.
        counter = 0;    // counter to count clock cycles upto 25000
    end

    always @(posedge clk) begin
        if (counter == 20'd25000)
            begin
                counter <= 1;
                out[1] <= out[0];
                out[2] <= out[1];
                out[3] <= out[2];
                out[0] <= out[3];
            end
        else
            begin
                counter <= counter + 1;
            end
    end

endmodule