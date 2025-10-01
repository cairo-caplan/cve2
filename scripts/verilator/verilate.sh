#!/bin/bash

CVE2_REPO_BASE="$(readlink -f -- "$( dirname -- "$( readlink -f -- "$0"; )"; )/../../")"
VLT_CONFIG="$CVE2_REPO_BASE/lint/verilator_waiver.vlt"

SV_DEPS="$CVE2_REPO_BASE/vendor/lowrisc_ip/ip/prim/rtl/prim_ram_1p_pkg.sv $CVE2_REPO_BASE/rtl/cve2_pkg.sv $CVE2_REPO_BASE/rtl/cve2_clock_gate.sv"
SV_TOP="$CVE2_REPO_BASE/rtl/cve2_top.sv"


verilator --lint-only \
          -Wall \
          -I$CVE2_REPO_BASE/rtl \
          -I$CVE2_REPO_BASE/vendor/lowrisc_ip/ip/prim/rtl \
          -I$CVE2_REPO_BASE/vendor/lowrisc_ip/dv/sv/dv_utils \
          ${VLT_CONFIG} \
          ${SV_DEPS} \
          ${SV_TOP}
