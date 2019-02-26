all: os.bin

run: all
	qemu-system-x86_64 os.bin

os.bin: boot.bin kernel.bin
	cat $^ > os.bin

# $ ^ is substituted with all of the target ’ s dependancy files
kernel.bin: kernel_entry.o kernel.o
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

# $ < is the first dependancy and $@ is the target file
kernel.o: kernel.c
	gcc -ffreestanding -c $< -o $@

# Build the kernel entry object file .
# Same as the above rule .
kernel_entry.o: kernel_entry.asm
	nasm $< -f elf64 -o $@

boot.bin: boot.asm
	nasm $< -f bin -o $@

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

clean:
	rm *.bin *.o

build:
	gcc -ffreestanding -c kernel.c -o kernel.o
	nasm kernel_entry.asm -f elf64 -o kernel_entry.o
	ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary
	nasm boot.asm -f bin -o boot.bin
	cat boot.bin kernel.bin > os.bin

build32:
	gcc -m32 -ffreestanding -c kernel.c -o kernel.o
	nasm kernel_entry.asm -f elf32 -o kernel_entry.o
	ld -m elf32_x86_64 -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary
	nasm boot.asm -f bin -o boot.bin
	cat boot.bin kernel.bin > os.bin
