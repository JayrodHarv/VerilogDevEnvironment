`timescale 1ns/1ps

module example (
    input a,
    input b,
    input c,
    output reg y
);

    always @(a or c) begin
        y = a | c;
    end

endmodule
