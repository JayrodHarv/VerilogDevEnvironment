`timescale 1ns/1ps // sets the time unit to 1ns and the time precision to 1ps

module four_bit_adder_test(
    output reg [3:0] a,
    output reg [3:0] b,
    output reg cin,
    input [3:0] sum,
    input cout
);

    integer file_descriptor; // integer to hold log data

    integer INPUT_DELAY = 50; // delay for input changes in ns

    initial begin
        $dumpfile("src/Homework_3/waves/dump.vcd");
        $dumpvars(0, four_bit_adder_test);

        file_descriptor = $fopen("src/Homework_3/logs/four_bit_adder.log", "w"); // opens a log file to write test logs to

        // 0 + 0 + 0 = 0
        // 0000 + 0000 + 0 = 0000
        a = 4'b0000; b = 4'b0000; cin = 0;
        #INPUT_DELAY; // delay for 50ns
        $fdisplay(file_descriptor, "a=%b b=%b cin=%b sum=%b cout=%b", a,b,cin,sum,cout);

        // 3 + 5 = 8
        // 0011 + 0101 = 1000
        a = 4'b0011; b = 4'b0101; cin = 0;
        #INPUT_DELAY; // delay for 50ns
        $fdisplay(file_descriptor, "a=%b b=%b cin=%b sum=%b cout=%b", a,b,cin,sum,cout);

        // 7 + 8 + 1 = 16
        // 0111 + 1000 + 1 = 10000
        a = 4'b0111; b = 4'b1000; cin = 1;
        #INPUT_DELAY; // delay for 50ns
        $fdisplay(file_descriptor, "a=%b b=%b cin=%b sum=%b cout=%b", a,b,cin,sum,cout);

        // 15 + 1 + 1 = 17
        // 1111 + 0001 + 1 = 10001
        a = 4'b1111; b = 4'b0001; cin = 1;
        #INPUT_DELAY; // delay for 50ns
        $fdisplay(file_descriptor, "a=%b b=%b cin=%b sum=%b cout=%b", a,b,cin,sum,cout);

        // 15 + 15 + 1 = 31
        // 1111 + 1111 + 1 = 11111
        a = 4'b1111; b = 4'b1111; cin = 1;
        #INPUT_DELAY; // delay for 50ns

        $fclose(file_descriptor); // closes and saves log file
        $finish; // end the simulation
    end
endmodule
