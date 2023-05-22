ARCH?=aarch64
CROSS_COMPILE?=aarch64-none-elf-

CFLAGS:=-Wall -Wextra  -ffreestanding -fno-stack-protector -fno-zero-initialized-in-bss -O0 -g -c -I./src/ #-Werror
LDFLAGS:=-nostdlib -T link.ld

CC=$(CROSS_COMPILE)gcc
LD=$(CROSS_COMPILE)ld
AS=$(CROSS_COMPILE)as
OBJCOPY=$(CROSS_COMPILE)objcopy
OBJDUMP=$(CROSS_COMPILE)objdump
