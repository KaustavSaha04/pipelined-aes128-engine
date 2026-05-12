# pipelined-aes128-engine

High-performance pipelined AES-128 hardware accelerator implemented in Verilog HDL for FPGA-based cryptographic processing.

This project presents a fully pipelined AES-128 encryption engine designed using synthesizable RTL and validated on Xilinx Vivado. The architecture achieves continuous high-throughput encryption by processing multiple 128-bit blocks simultaneously across pipeline stages.

The implementation follows the NIST FIPS-197 AES specification and demonstrates both hardware correctness and large-scale data verification using Python-based golden reference models.

---

## Features

- Fully synthesizable Verilog HDL implementation
- 10-stage pipelined AES-128 datapath
- High-throughput architecture
- Parallel SubBytes processing
- Optimized GF(2^8) arithmetic for MixColumns
- Complete AES-128 key expansion module
- Streaming RTL simulation support
- Python-based verification and image encryption demo
---

## Performance

| Metric | Value |
|---|---|
| AES Variant | AES-128 |
| Block Size | 128 bits |
| Pipeline Depth | 10 stages |
| Fill Latency | 12 clock cycles |
| Throughput | 128 bits/cycle |

---

# Repository Structure

```text
pipelined-aes128-engine/
│
├── demo/
│   ├── *.ipynb
│   ├── tux image files
│   └── python verification + ECB demo
│
├── vivado_project/
│   ├── AES_128.srcs/
│   ├── AES_128.xpr
│   └── simulation outputs
│
└── README.md
