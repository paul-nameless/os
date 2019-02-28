 # Automatically expand to a list of existing files that
# match the patterns
C_SOURCES=$(wildcard kernel/*.c drivers/*.c include/*.c)
# Create a list of object files to build , simple by replacing
# the ’.c ’ extension of filenames in C_SOURCES with ’.o ’
OBJ=${C_SOURCES:.c=.o}

all: build/os.bin

run:
	qemu-system-x86_64 build/os.bin

build/os.bin: build/boot.bin build/kernel.bin
	cat $^ > $@

# Link kernel object files into one binary , making sure the
# entry code is right at the start of the binary .
# $ ^ is substituted with all of the target ’ s dependancy files
build/kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

# Generic rule for building ’ somefile .o ’ from ’ somefile .c ’
%.o: %.c
	gcc -fno-pie -m32 -ffreestanding -c $< -o $@

# Build the kernel entry object file .
# Same as the above rule .
kernel/kernel_entry.o: kernel/kernel_entry.asm
	nasm $< -f elf32 -o $@

build/boot.bin: boot/boot.asm
	nasm $< -f bin -o $@

kernel.dis: build/kernel.bin
	ndisasm -b 32 $< > $@

clean:
	rm -fr *.bin *.dis *.o
	rm -fr kernel/*.o include/*.o drivers/*.o build/*.o build/*.bin

build: clean build/os.bin
