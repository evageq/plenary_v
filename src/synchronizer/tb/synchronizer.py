
import cocotb
from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock


@cocotb.test()
async def synch_test(dut):
    clock = Clock(dut.clk, 10, units="ns")  
    cocotb.start_soon(clock.start(start_high=False))

    clk = dut.clk
    d = dut.d
    out = dut.out

    input_signals = [1, 0, 1, 0, 0] 
    expected_out = [0, 0, 1, 1, 0]

    d.value = input_signals[0]

    for i in range(len(input_signals)):
        await RisingEdge(clk)
        assert expected_out[i] == out.value.integer
        d.value = input_signals[i]



