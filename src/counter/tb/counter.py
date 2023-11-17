import cocotb
from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock

if cocotb.simulator.is_running():
    UPPER_BOUND = int(cocotb.top.UPPER_BOUND)
    STEP = int(cocotb.top.STEP)


@cocotb.test()
async def count_every_num(dut):
    """ Go through every num."""

    clock = Clock(dut.clk, 10, units="ns")  
    cocotb.start_soon(clock.start(start_high=False))

    reset = dut.reset
    en = dut.en

    reset.value = 0
    en.value = 1

    start = 0
    expected_val = start

    for i in range(UPPER_BOUND):
        await RisingEdge(dut.clk)
        assert expected_val == dut.cnt.value.integer, f"""
        expected = {expected_val}, current_val = {dut.cnt.value.integer}
        """
        expected_val += STEP

@cocotb.test()
async def check_resest(dut):
    clock = Clock(dut.clk, 10, units="ns")  
    cocotb.start_soon(clock.start(start_high=False))

    reset = dut.reset
    en = dut.en

    reset.value = 0
    en.value = 1


    start = 0
    expected_val = start

    for i in range(10):
        await RisingEdge(dut.clk)
        expected_val += STEP

    reset.value = 1
    await RisingEdge(dut.clk)

    for i in range(10):
        await RisingEdge(dut.clk)
        assert 0 == dut.cnt.value.integer


    
