# OS

Practicing in asm and c by writing own simple OS


## TODO

* read n blocks: bash -c '$((($(ls -al build/os.bin | cut -d \' \' -f 8) - 512) / 512))'
* Write dockerfile
* make availability to run in bochs

## Roadmap

* Handling Interrupts
* Keyboard Driver
* Hard-disk Driver
* File System
* Implementing Processes
  * Single Processing
  * Multi-processing


## Install

#### MacOS

```
brew install i386-elf-gcc qemu
```

## Build and run

```
# build
make [build]
# run
make run
# clean
make clean
```
