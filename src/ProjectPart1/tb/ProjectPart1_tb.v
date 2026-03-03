module ProjectPart1_tb;

    wire y;
    wire a, b, c;

    ProjectPart1 mod (
        a, b, c, y
    );

    ProjectPart1_test test (
        a, b, c, y
    );

endmodule