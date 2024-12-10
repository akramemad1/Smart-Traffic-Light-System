`timescale 1ns / 1ps

module TL_tb();


reg s1_xL, s2_xL, s1_xR, s2_xR; 
reg s1_yU, s2_yU, s1_yD, s2_yD; 
reg clk, reset;                 
wire Xlg,Xrg,Xly,Xry, Xlr,Xrr, Yug,Ydg, Yuy,Ydy, Yur,Ydr;
integer x=0;
// Instantiate the DUT (Device Under Test)
Traffic_light_controller dut (.*);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 ns clock period (100 MHz clock frequency)
end

initial begin
    // Initialize inputs
    //Test 0 Reset >>> Expected All Leds Are red, State S6
    reset = 1;     
    @(negedge clk);
    //Test 1 Senario 1 Empty roads @ x,y >>> Expected State S0, Expected Output x is green, Y is red
    reset = 0; 
    s1_xL = 0; s2_xL = 0; s1_xR = 0; s2_xR = 0;
    s1_yU = 0; s2_yU = 0; s1_yD = 0; s2_yD = 0;
    repeat (30) @(negedge clk); 
    $display("Scenario 1: Xlg=%b, Xly=%b, Xlr=%b,Xrg=%b, Xry=%b, Xrr=%b, Yug=%b, Yuy=%b, Yur=%b, Ydg=%b, Ydy=%b, Ydr=%b", Xlg, Xly, Xlr, Xrg, Xry, Xrr,Yug,Yuy,Yur,Ydg,Ydy,Ydr);
    $display("Test 1 Complete.......................");
    //Test 2 car at x,y (no jam) >>> Expected X yellow then red, y green then yellow "Short wait" , Expected states: S0>S1>S3>S4>S0
    s1_xL = 1; s2_xL = 0; s1_xR = 1; s2_xR = 0;
    s1_yU = 1; s2_yU = 0; s1_yD = 1; s2_yD = 0;
    for(x=0;x<8;x=x+1)begin
    repeat (5) @(negedge clk);
    $display("After 5 Time unit......................."); 
    $display("Scenario 2: Xlg=%b, Xly=%b, Xlr=%b,Xrg=%b, Xry=%b, Xrr=%b, Yug=%b, Yuy=%b, Yur=%b, Ydg=%b, Ydy=%b, Ydr=%b", Xlg, Xly, Xlr, Xrg, Xry, Xrr,Yug,Yuy,Yur,Ydg,Ydy,Ydr);        
    end    
    x=0;
    $display("Test 2 Complete.......................");
    //Test 3 No jam X, Jam Y >>Expected X Yellow then red "Long wait", y will turn green"Long wait" then yellow, Expected states: S0>S1>S2>S4>S0
    s1_xL = 1; s2_xL = 0; s1_xR = 1; s2_xR = 0;
    s1_yU = 1; s2_yU = 1; s1_yD = 1; s2_yD = 1;
        repeat (60) @(negedge clk);    
    $display("Test 3 Complete.......................");
    s1_xL = 1; s2_xL = 0; s1_xR = 1; s2_xR = 1;
    s1_yU = 1; s2_yU = 0; s1_yD = 1; s2_yD = 1;
    $display("Test 4 Complete.......................");
    
   repeat (90) @(negedge clk);


    @(negedge clk);
    $stop;
end
endmodule