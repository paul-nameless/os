print:
    ;; print function, move address of string (that ends with 0) to bx register and call it
    pusha
    mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype BIOS routine
_print:
    mov al, [bx]
    cmp al, 0x0
    je _exit
    int 0x10
    add bx, 0x1
    jmp _print
_exit:
    popa
    ret


print_hex:
    ;; print hex in dx register
    pusha
    mov cx, 0
_loop:
    cmp cx, 4
    je _print_hex

    mov ax, dx
    and ax, 0xf

    cmp ax, 10
    jl _num

    add ax, 0x37
    jmp _cont

_num:
    add ax, 0x30

_cont:
    mov bx, HEX_OUT + 5
    sub bx, cx
    mov byte [bx], al

    shr dx, 4
    add cx, 1
    jmp _loop

_print_hex:
    mov bx, HEX_OUT
    call print
    popa
    ret

HEX_OUT:    db '0x0000', 0



disk_load:
    ;; load DH sectors to ES : BX from drive DL
    pusha
    push dx         ; Store DX on stack so later we can recall
                    ; how many sectors were request to be read ,
                    ; even if it is altered in the meantime
    mov ah, 0x02  ; BIOS read sector function
    mov al, dh     ; Read DH sectors
    mov ch, 0x00  ; Select cylinder 0
    mov dh, 0x00  ; Select head 0
    mov cl, 0x02  ; Start reading from second sector ( i.e.
                    ; after the boot sector )
    int 0x13       ; BIOS interrupt

    jc _disk_error       ; Jump if error ( i.e. carry flag set )

    pop dx              ; Restore DX from the stack
    cmp dh, al         ; if AL ( sectors read ) != DH ( sectors expected )
    jne _disk_error      ;   display error message
    popa
    ret

_disk_error:
    mov bx, DISK_ERROR_MSG
    call print
    popa
    ret
    ;; jmp $

  ; Variables
DISK_ERROR_MSG: db "Disk read error !", 0
