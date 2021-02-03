`define TICK #25000

module M(out, clk);
    input clk;
    output wire [3:0] out;
    reg [3:0] rotator;

    assign out = rotator;

    always @(posedge clk) begin
        rotator[1] <= `TICK rotator[0];
        rotator[2] <= `TICK rotator[1];
        rotator[3] <= `TICK rotator[2];
        rotator[0] <= `TICK rotator[3];
    end

    initial begin
        rotator = 4'b1000;
    end
endmodule