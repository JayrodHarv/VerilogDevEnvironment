`timescale 1ns/1ps

module mystery_module (
    input a,
    input b,
    input c,
    output reg y
);
    always @(a or b or c) begin
        y = a | c;
    end

endmodule

