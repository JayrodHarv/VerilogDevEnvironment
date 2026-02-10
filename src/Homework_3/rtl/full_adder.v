`timescale 1ns/1ps // sets the time unit to 1ns and the time precision to 1ps

module full_adder(
    input a,
    input b,
    input cin,
    output reg sum,
    output reg cout
);
    always @(a or b or cin) begin
        sum = a ^ b ^ cin;
        cout = (a & b) | (b & cin) | (a & cin);
    end

endmodule
