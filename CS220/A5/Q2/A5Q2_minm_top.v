// Top Module for minm module.

// Module Declaration
module minm_top;

    reg [2:0] A0;
    reg [2:0] A1;
    reg [2:0] A2;
    reg [2:0] A3;

    wire [1:0] out;

    // Declaring minm module declaration.
    minm uut(A0, A1, A2, A3, out);

    always @(A0 or A1 or A2 or A3 or out) begin
        $display("Time = %d, A0=%d, A1=%d, A2=%d, A3=%d, least_index=%d", $time, A0, A1, A2, A3, out);
    end

    // finish time of 10s.
    initial begin
        #10 $finish;
    end

    // 10 test cases.
    initial begin
        A0 = 0; A1 = 1; A2 = 2; A3 = 3;
        #1 $display("\n");

        A0 = 4; A1 = 2; A2 = 5; A3 = 7;
        #1 $display("\n");
        
        A0 = 6; A1 = 7; A2 = 3; A3 = 4;
        #1 $display("\n");
        
        A0 = 4; A1 = 6; A2 = 2; A3 = 1;
        #1 $display("\n");
        
        A0 = 4; A1 = 6; A2 = 5; A3 = 7;
        #1 $display("\n");
        
        A0 = 7; A1 = 3; A2 = 4; A3 = 6;
        #1 $display("\n");
        
        A0 = 5; A1 = 6; A2 = 2; A3 = 3;
        #1 $display("\n");
        
        A0 = 3; A1 = 1; A2 = 1; A3 = 3;
        #1 $display("\n");
        
        A0 = 0; A1 = 1; A2 = 0; A3 = 0;
        #1 $display("\n");
        
        A0 = 7; A1 = 7; A2 = 7; A3 = 7;
        #1 $display("\n");
    end

endmodule