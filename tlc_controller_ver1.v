`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//@DavidParr


module tlc_controller_ver1(
    output wire [1:0] highwaySignal, farmSignal,
    output wire [3:0] JB,
    input wire Clk,
    input wire Rst,
    input wire Sensor
    );
    
    //intermediate nets
    wire RstSync;
    wire RstCount;
    wire SensorSync;
    reg [30:0] Count;
    
    assign JB[3] = RstCount;
    
    synchronizer sync0(RstSync, Rst, Clk);
    synchronizer sync1(SensorSync, Sensor, Clk);
    
    tlc_fsm FSM(
        .state(JB[2:0]),
        .RstCount(RstCount),
        .highwaySignal(highwaySignal),
        .farmSignal(farmSignal),
        .Count(Count),
        .Clk(Clk),
        .Rst(RstSync),
        .Sensor(SensorSync)
    );
    
    //counter
        always@(posedge Clk )
        if(RstSync)
            begin
            Count <= 0;
            end
        else if(RstCount)
            begin
            Count <= 0;
            end
        else
            begin
            Count <= Count + 1;
            end
    
endmodule












