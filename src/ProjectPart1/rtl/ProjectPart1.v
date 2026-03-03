`timescale 1ns/1ps

module ProjectPart1 (
    input a,
    input b,
    input c,
    output reg y
);
    always @(a or c) begin
        y = a | c;
    end

endmodule
