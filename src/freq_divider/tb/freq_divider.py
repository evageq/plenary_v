import cocotb
from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock


if cocotb.simulator.is_running():
    DIV = int(cocotb.top.DIV)
    SIZE = int(cocotb.top.SIZE)


@cocotb.test()
async def div_2_test(dut):

    clock = Clock(dut.clk, 10, units="ns")  
    cocotb.start_soon(clock.start(start_high=False))

    clk = dut.clk
    rst = dut.rst
    divided_clk = dut.divided_clk

    clk.value = 0
    rst.value = 0



    cnt = 1

    await RisingEdge(clk)
    prev_val = divided_clk.value
    for i in range(512):
        if cnt == 2:
            assert divided_clk.value != prev_val
            prev_val = divided_clk.value
            cnt = 1
        cnt += 1

        await RisingEdge(clk)

