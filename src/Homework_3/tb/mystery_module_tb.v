
module mystery_module_tb;

    wire y;
    wire a, b, c;

    mystery_module mod (
        a, b, c, y
    );

    mystery_module_test test (
        a, b, c, y
    );

endmodule
