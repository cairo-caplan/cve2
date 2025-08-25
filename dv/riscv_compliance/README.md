CVE2 simulation for RISC-V Compliance Testing
=============================================

---
**NOTE**

**This document is NOT up-to-date**.

The RISC-V Compliance check, originally referred in this document made for 
lowRISC's Ibex core, [was made obsolete](https://github.com/riscv-non-isa/riscv-arch-test/tree/old-framework-2.x) 
as of 1st May 2022 in favour of the [RISC-V Architectural Test Framework (RISCOF)](https://github.com/riscv-software-src/riscof).

At the time of writing, we are working to adapt the instructions of this 
document to work with the RISCOF project - see issue [#221](https://github.com/openhwgroup/cve2/issues/221) of the repository.

---


This directory contains a compiled simulation of CVE2 to be used as target
in the [RISC-V Compliance Test](https://github.com/riscv/riscv-compliance).
In addition to CVE2 itself, it contains a 64 kB RAM and a memory-mapped helper
module to interact with the software, e.g. to dump out the test signature and to
end the simulation.

The simulation is designed for Verilator, but can be adapted to other simulators if needed.

How to run RISC-V Compliance on CVE2
------------------------------------

0. Check your prerequisites
   To compile the simulation and run the compliance test suite you need to
   have the following tools installed:
   - Verilator
   - fusesoc
   - srecord (for `srec_cat`)
   - A RV32 compiler

   On Ubuntu/Debian, install the required tools like this:

   ```sh
   sudo apt-get install srecord python3-pip
   pip3 install --user -U fusesoc
   ```

   We recommend installing Verilator from source as versions from Linux
   distributions are often outdated. See
   https://www.veripool.org/projects/verilator/wiki/Installing for installation
   instructions.

1. Build a simulation of CVE2

   ```sh
   cd $CVE2_REPO_BASE
   fusesoc --cores-root=. run --target=sim --setup --build openhwgroup:cve2:cve2_riscv_compliance --RV32E=0 --RV32M=cve2_pkg::RV32MNone
   ```

   You can use the two compile-time options `--RV32M` and `--RV32E` to
   enable/disable the M and E ISA extensions, respectively.

   You can now find the compiled simulation at `build/openhwgroup_cve2_cve2_riscv_compliance_0.1/sim-verilator/Vcve2_riscv_compliance`.

2. Get the RISC-V Compliance test suite

   The upstream RISC-V compliance test suite supports Ibex out of the box, 
   but still need to be adapted to the CVE2.
   <!-- TODO The steps below still need to be adapted and tested for the CVE2 -->

   ```
   git clone https://github.com/riscv/riscv-compliance.git
   cd riscv-compliance
   ```

3. Run the test suite
   ```sh
   cd $RISCV_COMPLIANCE_REPO_BASE
   # adjust to match your compiler name
   export RISCV_PREFIX=riscv32-unknown-elf- # or riscv32-corev-elf-
   # give the absolute path to the simulation binary compiled in step 1
   # e.g. export TARGET_SIM=/path/to/your/Vcve2_riscv_compliance
   export TARGET_SIM=../../build/openhwgroup_cve2_cve2_riscv_compliance_0.1/sim-verilator/Vcve2_riscv_compliance 

   export RISCV_DEVICE=rv32imc
   export RISCV_TARGET=cve2 # ibex
   # Note: rv32imc does not include the I and M extension tests
   make RISCV_ISA=rv32i && make RISCV_ISA=rv32im && make RISCV_ISA=rv32imc && \
      make RISCV_ISA=rv32Zicsr && make RISCV_ISA=rv32Zifencei
   ```

Compliance test suite system
----------------------------

This directory contains a system designed especially to run the compliance test
suite. The system consists of

- a CVE2 core,
- a bus,
- a single-port memory for data and instructions,
- a bus-attached test utility.

The CPU core boots from SRAM at address 0x0.

The test utility is used by the software to end the simulation, and to inform
the simulator of the memory region where the test signature is stored.
The bus host reads the test signature from memory.

The memory map of the whole system is as follows:

| Start   | End     | Size  | Device                         |
|---------|---------|-------|--------------------------------|
| 0x0     | 0xFFFF  | 64 kB | shared instruction/data memory |
| 0x20000 | 0x203FF | 1 kB  | test utility                   |


The test utility provides the following registers relative to the base address.

| Address | R/W | Description                                                         |
|---------|-----|---------------------------------------------------------------------|
| 0x0     | W   | Write any value to dump the test signature and terminate simulation |
| 0x4     | W   | Start address of the test signature                                 |
| 0x8     | W   | End address of the test signature                                   |
