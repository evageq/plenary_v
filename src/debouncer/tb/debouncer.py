import cocotb
from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock

import random


async def gen_bounce_pressed_button(clk, in_signal):
    for i in range(65536*2):
        if random.randint(0, 100) > 0:
            in_signal.value = 1
        else:
            in_signal.value = 0
        await Timer(random.randint(1, 3), units="ns")

    in_signal.value = 0


@cocotb.test()
async def press_button(dut):

    clock = Clock(dut.clk, 10, units="ns")  
    cocotb.start_soon(clock.start(start_high=False))

    clk = dut.clk
    clock_enable = dut.clock_enable
    in_signal = dut.in_signal

    clock_enable.value = 1
    in_signal.value = 0

    out_signal = dut.out_signal
    out_signal_enable = dut.out_signal_enable

    bounce_start = 4096
    test_pass = False
    for i in range(65536):
        if i == bounce_start:
            await cocotb.start(gen_bounce_pressed_button(clk, in_signal))
        await RisingEdge(clk)
        if i > bounce_start and out_signal_enable.value == 1:
            test_pass = True

    assert test_pass

