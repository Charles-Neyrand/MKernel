include generic_flags.mk

src_exception:= src/exception/evt.S $(wildcard ./src/exception/*.c)
srcs-y:= src/Entry.S $(wildcard src/io/UART/*.c) $(wildcard src/*.c) $(src_exception) # entry.S $(wildcard src/memdump/*.c) $(wildcard src/cli/*.c) $(wildcard src/UART/*.c) $(wildcard src/memtest/*.c)

# Convert .c and .S files to .o files in objs
objs:=$(patsubst %.c,%.c.o,$(srcs-y))
objs:=$(patsubst %.S,%.S.o,$(objs))

.PHONY: all
all: my_kernel.img my_kernel.dump pflash.bin
	$(info BUILD COMPLETED)

%.c.o: %.c
	$(V)$(CC) $(CFLAGS) -g $^ -o $@

%.S.o: %.S
	$(V)$(AS) $(SFLAGS) $^ -o $@

%.ld: %.lds
	$(V)$(AS) $^ -o $@

.PRECIOUS: %.elf
%.elf: $(objs)
	$(V)$(LD) $(LDFLAGS) $^ -o $@

.PRECIOUS: %.dump
%.dump: %.elf
	$(V)$(OBJDUMP) -D $^ > $@

.PRECIOUS: %.img
%.img: %.elf
	$(OBJCOPY) -O binary $< $@

.PRECIOUS: pflash.bin
pflash.bin: my_kernel.img
	$(V)dd if=/dev/zero of=$@ bs=1M count=512
	$(V)dd if=$< of=$@ conv=notrunc bs=1M count=20

.PHONY: launch
launch:
	$(V)qemu-system-aarch64 -nographic -machine virt -cpu cortex-a72 -kernel pflash.bin -serial mon:stdio -m 2G -smp 4 

launch-debug:
	$(V)qemu-system-aarch64 -nographic -machine virt -cpu cortex-a72 -kernel pflash.bin -serial mon:stdio -m 2G -smp 4 -d int,in_asm 


launch-dtb:
	$(V)qemu-system-aarch64 -nographic -machine virt -cpu cortex-a72 -kernel pflash.bin -serial mon:stdio -m 2G -smp 4 -machine dumpdtb=qemu.dtb



.PHONY: clean
clean:
	rm -rf *.elf *.bin *.o */*.o */*/*.o *.img *.dump
