`timescale 1ns/1ps // sets the time unit to 1ns and the time precision to 1ps

module mystery_module_test(
    output reg a,
    output reg b,
    output reg c,
    input y
);

    integer file_descriptor; // integer to hold log data

    reg [3:0] i; // 4-bit register to iterate through all combinations of a, b, c

    initial begin
        $dumpfile("src/Homework_3/waves/dump.vcd");
        $dumpvars(0, mystery_module_test);

        file_descriptor = $fopen("src/Homework_3/logs/mystery_module.log", "w"); // opens a log file to write test logs to

        // create for loop to test all combinations of a, b, c
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, c} = i; // assign the value of i to a, b, c
            #50; // delay for 50ns
            $fdisplay(file_descriptor, "a=%b b=%b c=%b y=%b", a,b,c,y);
        end

        $fclose(file_descriptor); // closes and saves log file
        $finish; // end the simulation
    end
endmodule
