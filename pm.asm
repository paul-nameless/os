 ; A boot sector that enters 32 - bit protected mode.
    [org 0x7c00]
    [bits 16]

    mov bp, 0x9000                       ; Set the stack.
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print

    call switch_to_pm                      ; Note that we never return from here.

    jmp $

    %include      "print.asm"
    %include      "gdt.asm"
    %include      "print_pm.asm"
    %include      "switch_to_pm.asm"

    [bits 32]
     ; This is where we arrive after switching to and initialising protected mode.
BEGIN_PM:

    ;; mov ebx, 0xb8000    ; The video address
    ;; mov al, '>'         ; The character to be print
    ;; mov ah, 0x0F        ; The color: white(F) on black(0)
    ;; mov [ebx], ax        ; Put the character into the video memory

   mov ebx, MSG_PROT_MODE
   call print_string_pm ; Use our 32 - bit print routine.

   jmp $                      ; Hang.

 ; Global variables
    MSG_REAL_MODE db "Started in 16 - bit Real Mode", 0
    MSG_PROT_MODE db "Successfully landed in 32 - bit Protected Mode", 0

 ; Bootsector padding
    times 510-($-$$) db 0
    dw 0xaa55
