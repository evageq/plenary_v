`timescale 1ns / 1ps
module PWM_FSM #(UDW = $clog2(1000000))
    (
        input CLK,
        input RST,
        input CE,
        input [UDW-1:0] PWM_IN,
        output reg PWM_P
    );

reg [UDW-1:0] PWM_REG, FSM_STATE;

always @ (posedge CLK, posedge RST)
    if(RST)
        begin
        PWM_P <= 0;
        FSM_STATE <= 0;
        PWM_REG <= 0;
        end
    else if(CE)
        case(FSM_STATE)
            0:
                begin
                PWM_P <= 0;
                FSM_STATE <= {UDW{1'b1}}-1;
                end
            {UDW{1'b1}}-1:
                begin
                    if (PWM_REG > {UDW{1'b1}}-1)
                        PWM_P <= 1;
                    else
                        PWM_P <= 0;
                    FSM_STATE <= {UDW{1'b1}};
                    PWM_REG <= PWM_IN;
                end
            {UDW{1'b1}}:
                begin
                    if (PWM_REG == 0)
                        PWM_P <= 0;
                    else if (PWM_REG != 0)
                        PWM_P <= 1;
                    FSM_STATE <= 1;
                end
            default:
                begin
                    if (PWM_REG > FSM_STATE)
                        PWM_P <= 1;
                    else
                        PWM_P <= 0;
                    FSM_STATE <= FSM_STATE + 1;
                end
        endcase

endmodule