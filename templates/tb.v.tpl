module {{NAME}}_tb;

    wire y;
    wire a, b, c;

    {{NAME}} mod (
        a, b, c, y
    );

    {{NAME}}_test test (
        a, b, c, y
    );

endmodule