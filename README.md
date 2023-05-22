# MKernel
First kernel. Developped specificly for aarch64

To launch

qemu-system-aarch64 -nographic -machine virt -cpu cortex-a72 -kernel pflash.bin  -serial mon:stdio -m 2G -smp 4
