
module four_bit_adder_tb;

    wire [3:0] sum;
    wire cout;
    wire [3:0] a, b;
    wire cin;

    four_bit_adder adder (
        a, b, cin, sum, cout
    );

    four_bit_adder_test test (
        a, b, cin, sum, cout
    );

endmodule
