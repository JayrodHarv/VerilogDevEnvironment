`timescale 1ns/1ps // sets the time unit to 1ns and the time precision to 1ps

module {{NAME}}_test(
    output reg a,
    output reg b,
    output reg c,
    input y
);

    integer file_descriptor; // integer to hold log data

    reg [3:0] i; // 4-bit register to iterate through all combinations of a, b, c

    initial begin
        $dumpfile("src/{{PROJ}}/waves/dump.vcd");
        $dumpvars(0, {{NAME}}_test);

        file_descriptor = $fopen("src/{{PROJ}}/logs/{{NAME}}.log", "w"); // opens a log file to write test logs to

        // create for loop to test all combinations of a, b, c
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, c} = i; // assign the value of i to a, b, c
            #50; // delay for 50ns
            $fdisplay(file_descriptor, "Time: %0t | a: %b | b: %b | c: %b | y: %b", $time, a, b, c, y); // log the current values of a, b, c, and y to the log file
        end

        $fclose(file_descriptor); // closes and saves log file
        $finish; // end the simulation
    end
endmodule
