riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32i -nostartfiles \
 ../../lib/startup.s ../../lib/stdio.c -T ../../lib/link_hydrogensoc.ld hello.c -o hello.elf $1 $2 $3 $4
