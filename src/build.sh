#!/bin/bash

as -g -o protected_mode.o protected_mode.S
ld --oformat binary -o protected_mode.img -T linker.ld protected_mode.o

#qemu-system-x86_64 -hda protected_mode.img

qemu-system-x86_64 -drive 'file=protected_mode.img,format=raw' -serial mon:stdio -smp 2 -S -s &
gdb -quiet -tui -x gdb.gdb protected_mode.img
