`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//@DavidParr


module tlc_fsm(
    output reg [2:0] state,
    output reg RstCount,
    output reg [1:0] highwaySignal, farmSignal,
    input wire [30:0] Count,
    input wire Clk, Rst, Sensor
    );
//define params
parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100,
          S5 = 3'b101,
          //GYR
          Green = 2'b11,
          Yellow = 2'b10,
          Red = 2'b01;
          
   
//intermidaiate nets
reg [2:0] nextState;


//Movement w/ counter
always@(*)
    case(state)

    //State 0
    S0: begin
            //Signals
            highwaySignal <= Red;
            farmSignal <= Red;
    
            if(Count >= 50000000)
                begin
                nextState <= S1;
                RstCount <= 1;
                end
            else
                begin
                nextState <= S0;
                RstCount <= 0;
                end
        end
    //State 1
    S1: begin
            //Signals
            highwaySignal <= Green;
            farmSignal <= Red;
    
            if((Count >= 1500000000) && Sensor == 1)
                begin
                nextState <= S2;
                RstCount <= 1;
                end
            else
                begin
                nextState <= S1;
                RstCount <= 0;
                end
        end 
    //State 2
    S2: begin
            //Signals
            highwaySignal <= Yellow;
            farmSignal <= Red;
    
            if(Count >= 150000000)
                begin
                nextState <= S3;
                RstCount <= 1;
                end
            else
                begin
                nextState <= S2;
                RstCount <= 0;
                end
        end 
    //State 3
    S3: begin
            //Signals
            highwaySignal <= Red;
            farmSignal <= Red;
    
            if(Count >= 50000000)
                begin
                nextState <= S4;
                RstCount <= 1;
                end
            else
                begin
                nextState <= S3;
                RstCount <= 0;
                end
        end 
    //State 4
    S4: begin
            //Signals
            highwaySignal <= Red;
            farmSignal <= Green;
    
           if((Count >= 750000000) || ((Count >= 150000000) && (Sensor == 0)))
                begin
                nextState <= S5;
                RstCount <= 1;
                end
            else
                begin
                nextState <= S4;
                RstCount <= 0;
                end
        end       
    //State 5
    S5: begin
            //Signals
            highwaySignal <= Red;
            farmSignal <= Yellow;
    
            if(Count >= 150000000)
                begin
                nextState <= S0;
                RstCount <= 1;
                end
            else
                begin
                nextState <= S5;
                RstCount <= 0;
                end
        end      
    endcase

//Reset function
always@(posedge Clk)
    if(Rst)
        state <= S0;
    else
        state <= nextState;
    
endmodule














