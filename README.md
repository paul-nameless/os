```
gcc -ffreestanding -c kernel.c -o kernel.o
ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary
nasm boot.asm -f bin -o boot.bin
cat boot.bin kernel.bin > os.bin
qemu-system-x86_64 os.bin
```
