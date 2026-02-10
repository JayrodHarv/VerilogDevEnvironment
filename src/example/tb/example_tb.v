module example_tb;

    wire y;
    wire a, b, c;

    example mod (
        a, b, c, y
    );

    example_test test (
        a, b, c, y
    );

endmodule
