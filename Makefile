all: os.bin

run: all
	qemu-system-x86_64 os.bin

os.bin: boot.bin kernel.bin
	cat $^ > os.bin

# $ ^ is substituted with all of the target ’ s dependancy files
kernel.bin: kernel_entry.o kernel.o
	ld -m elf_i386 -o kernel.bin -Ttext 0x1000 $^ --oformat binary

# $ < is the first dependancy and $@ is the target file
kernel.o: kernel.c
	gcc -fno-pie -m32 -ffreestanding -c $< -o $@

# Build the kernel entry object file .
# Same as the above rule .
kernel_entry.o: kernel_entry.asm
	nasm $< -f elf32 -o $@

boot.bin: boot.asm
	nasm $< -f bin -o $@

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

clean:
	rm *.bin *.o

build: os.bin
