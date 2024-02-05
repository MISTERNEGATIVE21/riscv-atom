![RISCVAtom-header](docs/diagrams/rvatom-header.drawio.png)

# RISCV-Atom

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/) [![atomsim](https://github.com/saursin/riscv-atom/actions/workflows/atomsim.yml/badge.svg)](https://github.com/saursin/riscv-atom/actions/workflows/atomsim.yml) [![libcatom](https://github.com/saursin/riscv-atom/actions/workflows/libcatom.yml/badge.svg)](https://github.com/saursin/riscv-atom/actions/workflows/libcatom.yml) [![scar](https://github.com/saursin/riscv-atom/actions/workflows/scar.yml/badge.svg)](https://github.com/saursin/riscv-atom/actions/workflows/scar.yml) [![Documentation Status](https://readthedocs.org/projects/riscv-atom/badge/?version=latest)](https://riscv-atom.readthedocs.io/en/latest/?badge=latest)


RISC-V Atom is an open-source soft-core processor platform targeted for FPGAs. It is complete hardware prototyping and software development environment based around **Atom**, which is a 32-bit embedded-class processor based on the [RISC-V](https://riscv.org/) Instruction Set Architecture (ISA). 

Key highlights of the RISC-V Atom projects are are listed below:

- Atom processor implements `RV32IC_Zicsr` ISA as defined in the [RISC-V unprivileged ISA manual](https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf).
- Simple 2-stage pipelined architecture, ideal for smaller FPGAs.
- Wishbone ready CPU interface.
- Support for RISC-V interrupts and exceptions.
- Interactive RTL simulator - **AtomSim**.
- In-house verification framework - **SCAR**.
- FPGA-ready SoC implementation - **HydrogenSoC**.
- Tiny libc like standard library - **libcatom**.
- Wide range of example programs.
- Open source under [MIT License](https://en.wikipedia.org/wiki/MIT_License).  


> ***To checkout this project, Please refer to the [Getting Started Guide](https://riscv-atom.readthedocs.io/en/latest/pages/getting-started/riscv-atom.html)***.
> ***Use the `dev` branch, if you like to see the latest additions to the project***

## Useful Links
1. [Project Website](https://sites.google.com/view/saurabh-singh-web/projects/risc-v-atom?authuser=0)
2. [Project Documentation](https://riscv-atom.readthedocs.io/en/latest/index.html)
    - [Getting Started Guide](https://riscv-atom.readthedocs.io/en/latest/pages/getting-started/prerequisites.html)
    - [Examples Guide](https://riscv-atom.readthedocs.io/en/latest/pages/getting-started/examples.html)


<!-- 5. AtomSim Source Documentation -->

<!--
## Other related projects
1. **AtomShell**: A simple shell for RISC-V Atom based SoCs : [AtomShell Github](https://github.com/saurabhsingh99100/atomshell)
-->

## License
This project is open-source under [MIT license](https://github.com/saursin/riscv-atom/blob/main/LICENSE)!
