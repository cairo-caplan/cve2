.. _examples:

Examples
========

To make use of CVE2 please review the :ref:`core-integration` section of this document.
The CVE2 is simple enough to integrate into your own platform.
To get you started, we suggest a couple of very useful open-source platforms.

Ibex Minimal System
-------------------

A minimal example for the `Arty A7 <https://reference.digilentinc.com/reference/programmable-logic/arty-a7/start>`_ FPGA Development board developed for Ibex should be portable to the CVE2 without significant effort.
If you are interested in using the Ibex minimal example, it can be found `here <https://github.com/lowRISC/ibex/tree/master/examples/simple_system>`_.

X-HEEP
------

The CV32E20 (a specific configuration of the CVE2) has been integrated into the `X-HEEP <https://github.com/esl-epfl/x-heep/tree/main>`_ (eXtendable Heterogeneous Energy-Efficient Platform).
X-HEEP is a RISC-V microcontroller implemented in SystemVerilog that can be configured to integrate a number of CORE-V processors.
X-HEEP provides a simple customizable MCU to get you up and running quickly.

CROC
----

The CV32E20 has also been integrated into the `CROC <https://github.com/pulp-platform/croc>`_ project (An End-to-End Open-Source Extensible RISC-V MCU Platform to Democratize Silicon).
CROC is a PULP platform SoC for education, easy to understand and extend with a full flow for a physical design. It states it contains all the necessary scripts to produce an SoC containing the CVE2 on `IHPs open-source 130nm technology <https://github.com/IHP-GmbH/IHP-Open-PDK/tree/main>`_.



