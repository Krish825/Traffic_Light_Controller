`timescale 1ns / 1ps 
module traffic_light_controller_tb;

// Inputs driven by the testbench
logic clk;
logic reset_n;

// Outputs observed from the DUT
logic ns_red;
logic ns_yellow;
logic ns_green;

logic ew_red;
logic ew_yellow;
logic ew_green;
 // Device Under Test (DUT) 
 traffic_light_controller dut (
    .clk(clk),
    .reset_n(reset_n),

    .ns_red(ns_red),
    .ns_yellow(ns_yellow),
    .ns_green(ns_green),

    .ew_red(ew_red),
    .ew_yellow(ew_yellow),
    .ew_green(ew_green)
 );

 // clock generation
 initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
 end

 //Reset generation 
 initial begin
    reset_n = 1'b0; // Assert reset
    #12;
    reset_n =1'b1; // Release reset
 end
// Check S0: North- South Green, East- West Red
initial begin
    #16;

    if(ns_green !== 1'b1 || ew_red !==1'b1||
    ns_red !== 1'b0 || ns_yellow !== 1'b0||
    ew_green !== 1'b0 || ew_yellow !==1'b0) begin
        $display("FAIL: S0 output check");
        $finish;
    end

    $display("PASS: S0 output check");
    end

// Check S1: North-South Yellow, East-West Red
initial begin
    #66;

    if(ns_yellow !== 1'b1 || ew_red !==1'b1||
    ns_red !== 1'b0 || ns_green !== 1'b0||
    ew_green !== 1'b0 || ew_yellow !== 1'b0) begin
        $display("FAIL: S1 output check");
        $finish;

    end

    $display("PASS:S1 output check");
end

// Check S2: Both directions Red
initial begin
    #76;
    if(ns_red !== 1'b1 || ew_red !== 1'b1||
    ns_green !== 1'b0 || ns_yellow !== 1'b0 ||
    ew_green !== 1'b0 || ew_yellow !== 1'b0) begin
        $display("FAIL: S2 output check");
        $finish;
    end

    $display("PASS: S2 output check");
end

// Check S3: East-West Green
    initial begin
        #96;

        if (ns_red !== 1'b1 || ew_green !== 1'b1 ||
            ns_green !== 1'b0 || ns_yellow !== 1'b0 ||
            ew_red !== 1'b0 || ew_yellow !== 1'b0) begin
            $display("FAIL: S3 output check");
            $finish;
        end

        $display("PASS: S3 output check");
    end

    // Check S4: East-West Yellow
    initial begin
        #146;

        if (ns_red !== 1'b1 || ew_yellow !== 1'b1 ||
            ns_green !== 1'b0 || ns_yellow !== 1'b0 ||
            ew_red !== 1'b0 || ew_green !== 1'b0) begin
            $display("FAIL: S4 output check");
            $finish;
        end

        $display("PASS: S4 output check");
    end

 // Check S5: Both directions Red
    initial begin
        #156;

        if (ns_red !== 1'b1 || ew_red !== 1'b1 ||
            ns_green !== 1'b0 || ns_yellow !== 1'b0 ||
            ew_green !== 1'b0 || ew_yellow !== 1'b0) begin
            $display("FAIL: S5 output check");
            $finish;
        end

        $display("PASS: S5 output check");
    end
    

 // End Simulation automatically 
 initial begin
    #200;
    $finish ;
 end

 //Waveform generation
 initial begin
    $dumpfile("traffic_light_controller.vcd");
    $dumpvars(0,traffic_light_controller_tb);
 end

endmodule