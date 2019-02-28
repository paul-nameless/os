 ; A boot sector that enters 32 - bit protected mode.
    [org 0x7c00]
    KERNEL_OFFSET equ 0x1000 ; This is the memory offset to which we will load our kernel
    mov [BOOT_DRIVE], dl ; BIOS stores our boot drive in DL , so it ’s
                         ; best to remember this for later.

    mov bp, 0x9000                       ; Set the stack.
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print

    call load_kernel

    call switch_to_pm                      ; Note that we never return from here.

    jmp $

    %include      "boot/print.asm"
    %include      "boot/gdt.asm"
    %include      "boot/print_pm.asm"
    %include      "boot/switch_to_pm.asm"
    %include      "boot/disk_load.asm"

    [bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL   ; Print a message to say we are loading the kernel
    call print

    mov bx, KERNEL_OFFSET            ; Set - up parameters for our disk_load routine , so
    ;; mov dh, 15                       ; that we load the first 15 sectors ( excluding
    mov dh, 4                       ; that we load the first 15 sectors ( excluding
    mov dl, [BOOT_DRIVE]           ; the boot sector ) from the boot disk ( i.e. our
    call disk_load                    ; kernel code ) to address KERNEL_OFFSET
    ret

    [bits 32]
     ; This is where we arrive after switching to and initialising protected mode.
BEGIN_PM:

    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Use our 32 - bit print routine.

    call KERNEL_OFFSET               ; Now jump to the address of our loaded

 ; Global variables
    BOOT_DRIVE db   0
    MSG_REAL_MODE db "Started in 16 - bit Real Mode", 0
    MSG_PROT_MODE db "Successfully landed in 32 - bit Protected Mode", 0
    MSG_LOAD_KERNEL db "Loading kernel into memory..." , 0

 ; Bootsector padding
    times 510-($-$$) db 0
    dw 0xaa55
