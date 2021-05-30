# riscv-atom

Atom is an embedded-class processor based on the RISC-V instruction set architecture.

- Atom has a non pipe-lined architecture, optimised for small FPGAs.

- Atom Implements RV32I  instruction set architecture.

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)


## Table of Contents

1. [Atom Architecture](Atom-Architecture)
2. [Atom SoC](Atom-SoC)
3. [Prerequisites](Prerequisites)
4. [Getting Started](Getting-Started)
5. [Simulation](Simulation)
6. [FPGA Implementation](FPGA-Implementation)
7. [License](License)

## Atom Architecture

Atom is an embedded class processor written in verilog. It implements open-source RISC-V instruction set architecture (RV32I). Atom contains a two stage pipeline inspired from arm cortex m0+. 

![AtomRV Architecture](doc/diagrams/atomRV_architecture_diagram.png)

### Pipeline Stages

- Stage-1 : In this stage, an instruction is fetched from instruction memory and program counter is incremented.
- Stage-2 : In this stage, the instruction is decoded, all the signal are assigned in order to execute the instruction. & registers are fetched. A 32 bit immediate is generated by the ImmGen unit. ALU then execute the instruction which is followed by write-back into the register file. Branch calculation also happens in this stage and if branch is taken, the pipeline is flushed. Comparator module in this stage is used for all the instructions that involve comparison like `slt`, `slti`, `beq`, `bltu` etc.



## AtomRVSoC

Atom, when integrated with the system bus and Peripherals like counters, timers, UART controller, FLASH controller etc. is called ***Atom System on Chip (SoC)***. Atom SoC is targeted towards softcore as well as hardcore implementations.

Tentative specs are listed below:

- Core: Atom (2-stage pipelined)

- Bus Interface: Wishbone b4

- ROM: 64Kb

- RAM: 8Kb

- Interrupts: 1 NMI + 32 Physical interrupts (PLIC)

- GPIO: 16 (PWM enabled: 6)

- SPI : 2

- I2C: 2

- Clock : []

  

## Prerequisites

Run apt update

```bash
$ sudo apt update
```

Install git, make, gcc & other tools

```bash
$ sudo apt-get install git build-essential
```

Install verilator

````bash
$ sudo apt install verilator
````

Install GTK Wave

```bash
$ sudo apt-get install gtkwave
```



**Note : ** The following packages are optional and are only required for generating documentation using doxygen

Install doxygen

```bash
$ sudo apt install doxygen
```

Install texlive packages (Only needed for [pdf generation](Getting-Started))

```bash
$ sudo apt-get -y install texlive-latex-recommended texlive-pictures texlive-latex-extra
```



## Getting Started

Get [RISC-V tools](https://github.com/riscv/riscv-tools) & [RISC-V GNU Toolchain](https://github.com/riscv/riscv-gnu-toolchain.git) . Make sure that your `RISCV` environment variable points to your RISC-V installation (see the RISC-V tools and related projects for further information).

**Clone the repository**

```bash
$ git clone https://github.com/saurabhsingh99100/riscv-atom.git
$ cd riscv-atom
```

**Building the Simulator**

Run make from the parent directory

```bash
$ make atomsim
```

This will create a build/bin directory inside the parent directory. The simulation executable will be available here.

```bash
$ cd build/bin
$ ./atomsim ../example/hello/hello.elf
```



**Generating atomsim code documentation using doxygen**

Run make from the parent directory

```bash
$ make doxy-doc
```

This will generate *latex* and *html* documentation in their respective folders under the doc directory

To generate *pdf* file from the latex files, go to `doc/latex` directory and run `make`



**Generating "Documentation & User Manual" pdf**

```bash
$ make documentation
```



## AtomSim

**CLI Options**

```
Usage:
$ atomsim [options] <executable_file>

options:
-d 					: run simulation in debug mode
-h	| --help 	    : display this message
-v          		: turn on verbose
-t <file>			: turn on vcd tracing
--version			: display version information
--trace-dir <dir>	: specify trace directory (default is current directory)
```

### Modes of operation

Atomsim supports two modes of simulation: a). debug/interactive, & b) test. 

#### 1. Debug/Interactive Mode

In this mode of simulation, Contents of Program counter (in both stages), Instruction register, instruction disassembly and contents of registers (if verbosity is set) are printed to stdout. A console with symbol `:` is also displayed at the bottom if screen for user to enter various commands to control the simulation. To step through one clock cycle, user can simply press `enter` key (without entering anything in console).

To invoke interactive debug mode, invoke atomsim with `-d` & `-v`flag:

```
$ ./build/bin/atomsim hello.elf -d -v
Segments found : 2
Loading Segment 0 @ 0x00000000 --- done
Loading Segment 1 @ 0x00010000 --- done
Entry point : 0x00000000
Initialization complete!
: 
-< 1 >--------------------------------------------
F-STAGE  |  pc : 0x00000034  (+4) () 
E-STAGE  V  pc : 0x00000000   ir : 0x00010517   [addi x1, 0x33f]
---------------------------------------------------
 x0  (zero) : 0x00000000   x16 (a6)   : 0x00000000  
 x1  (ra)   : 0x00000000   x17 (a7)   : 0x00000000  
 x2  (sp)   : 0x00000000   x18 (s2)   : 0x00000000  
 x3  (gp)   : 0x00000000   x19 (s3)   : 0x00000000  
 x4  (tp)   : 0x00000000   x20 (s4)   : 0x00000000  
 x5  (t0)   : 0x00000000   x21 (s5)   : 0x00000000  
 x6  (t1)   : 0x00033000   x22 (s6)   : 0x00000400  
 x7  (t2)   : 0x00000000   x23 (s7)   : 0x00000000  
 x8  (s0/fp): 0x00000000   x24 (s8)   : 0x00000000  
 x9  (s1)   : 0x00000000   x25 (s9)   : 0x00000000  
 x10 (a0)   : 0x00000000   x26 (s10)  : 0x00000000  
 x11 (a1)   : 0x00000000   x27 (s11)  : 0x00000000  
 x12 (a2)   : 0x00000000   x28 (t3)   : 0x00000000  
 x13 (a3)   : 0x00000000   x29 (t4)   : 0x00000000  
 x14 (a4)   : 0x00000000   x30 (t5)   : 0x00000000  
 x15 (a5)   : 0x00000000   x31 (t6)   : 0x00000000  
: 
```

##### Interacting With Debug Console

###### Displaying contents of a register

Contents of register can be displayed simply typing its name (abi names are also supported) on the console. ex:

```
: x0
x0 = 0x000045cf
: ra
ra = 0x0000301e
```

use ':' to display a range of registers. ex:

```
: x0 : x1
```



###### Displaying Contents of a memory location

`: m <address> <sizetag>`

address can be specified in hex or decimal.

use *sizetag* to specify the size of data to be fetched, `b` for byte, `h` for half-word and `w` for word (default is word).

```
: m 0x30 b
mem[0x30] = 01
```

use ':' to display contents of memory in a range. ex:

```
: m 0x32:0x38 w
mem[0x30] = 01 30 cf 21
mem[0x38] = 11 70 ab cf
```



###### Generating VCD traces

Tracing can be enabled by:

```
: trace out.vcd
Trace enabled : "./out.vcd" opened for output.
```

or by passing `--trace <file>` option while invoking atomsim.

Tracing can be disabled by:

```
: notrace
Trace disabled
```



###### Controlling execution

You can advance by one instruction by pressing the ***enter-key***. You can also execute until a desired equality is reached:

- until value of a register \<reg> becomes \<value>

  ```
  : until <reg> <value>
  ```

- until value of a memory address \<address> becomes \<value>

  ```
  : until <address> <value>
  ```

- while \<condition> is true

  ```
  : while <condition>
  ```

- Execute for specified number of ticks

  ```
  : for <ticks>
  ```

- You can continue execution indefinitely by:

  ```
  : r
  ```

- To end the simulation from the debug prompt:

  ```
  : q
  ```

  or 

  ```
  : quit
  ```

  

> At any point during execution (even without -d), you can enter the interactive debug mode with `ctrl+c`.

###### Miscellaneous

`verbose-on` & `verbose off` commands can be used to turn on /off verbosity.



#### 2. Test Mode

In this mode of simulation, no debug information is printed. Instead memory addresses `TX_ADDRESS=0x0001ffff` & `TX_ACK_ADDRESS = 0x0001fffe` are listened. The contents of `TX_ADDRESS` is printed on stdout whenever LSB of `TX_ACK_ADDRESS` shows `0->1` transition.

```
$ ./build/bin/atomsim hello.elf 
Segments found : 2
Loading Segment 0 @ 0x00000000 --- done
Loading Segment 1 @ 0x00010000 --- done
Entry point : 0x00000000
Initialization complete!
_________________________________________________________________
Hello World!

SUCCESS : Exiting due to EBREAK
```



## FPGA Implementation

Yosys systhesis results:

````
=== $paramod\RegisterFile\REG_WIDTH=32\REG_ADDR_WIDTH=5 ===

   Number of wires:               2144
   Number of wire bits:           3222
   Number of public wires:          40
   Number of public wire bits:    1106
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:               3169
     FDRE                          992
     LUT1                            8
     LUT2                           31
     LUT3                           59
     LUT4                          938
     LUT5                          176
     LUT6                          764
     MUXCY                          12
     MUXF7                         174
     XORCY                          15

   Estimated number of LCs:       1937

=== Alu ===

   Number of wires:               1124
   Number of wire bits:           1281
   Number of public wires:           4
   Number of public wire bits:      99
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:               1212
     LUT1                           32
     LUT2                          137
     LUT3                           29
     LUT4                           22
     LUT5                           33
     LUT6                          529
     MUXCY                          62
     MUXF7                         226
     MUXF8                          78
     XORCY                          64

   Estimated number of LCs:        656

=== AtomRV ===

   Number of wires:                314
   Number of wire bits:           1142
   Number of public wires:          37
   Number of public wire bits:     648
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                749
     $paramod\RegisterFile\REG_WIDTH=32\REG_ADDR_WIDTH=5      1
     Alu                             1
     Decode                          1
     FDRE                          128
     LUT1                            1
     LUT2                          131
     LUT3                          154
     LUT4                            8
     LUT5                           39
     LUT6                          113
     MUXCY                          95
     MUXF7                          40
     MUXF8                           4
     XORCY                          33

   Estimated number of LCs:        314

=== AtomRVSoC ===

   Number of wires:                 10
   Number of wire bits:            167
   Number of public wires:          10
   Number of public wire bits:     167
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                  1
     AtomRV                          1

   Estimated number of LCs:          0

=== Decode ===

   Number of wires:                126
   Number of wire bits:            253
   Number of public wires:          19
   Number of public wire bits:     146
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                153
     LUT2                           21
     LUT3                           11
     LUT4                           16
     LUT5                            5
     LUT6                           71
     MUXF7                          24
     MUXF8                           5

   Estimated number of LCs:        103

=== design hierarchy ===

   AtomRVSoC                         1
     AtomRV                          1
       $paramod\RegisterFile\REG_WIDTH=32\REG_ADDR_WIDTH=5      1
       Alu                           1
       Decode                        1

   Number of wires:               3718
   Number of wire bits:           6065
   Number of public wires:         110
   Number of public wire bits:    2166
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:               5280
     FDRE                         1120
     LUT1                           41
     LUT2                          320
     LUT3                          253
     LUT4                          984
     LUT5                          253
     LUT6                         1477
     MUXCY                         169
     MUXF7                         464
     MUXF8                          87
     XORCY                         112

   Estimated number of LCs:       2967
````



Xilinx vivado synthesis results: 

| FPGA                     | LUT Utilization | Power Consumption | Fmax |
| ------------------------ | --------------- | ----------------- | ---- |
| Xilinx Spartan-6 XC6SLX9 | -               | -                 | -    |
| Xilinx Atrix-7           | -               | -                 | -    |



## License

Atom is open-source under the MIT license! 

Click [here](LICENSE) to know more.
