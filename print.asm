;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; print string
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print:
    ;; print function, move address of string (that ends with 0) to bx register and call it
    pusha
    mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype BIOS routine
_print:
    mov al, [bx]
    cmp al, 0x0
    je _print_exit
    int 0x10
    add bx, 0x1
    jmp _print
_print_exit:
    popa
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; print_hex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_hex:
    ;; print hex in dx register
    pusha
    mov cx, 0
_print_hex_loop:
    cmp cx, 4
    je _print_hex

    mov ax, dx
    and ax, 0xf

    cmp ax, 10
    jl _print_hex_num

    add ax, 0x37
    jmp _print_hex_cont

_print_hex_num:
    add ax, 0x30

_print_hex_cont:
    mov bx, _HEX_OUT + 5
    sub bx, cx
    mov byte [bx], al

    shr dx, 4
    add cx, 1
    jmp _print_hex_loop

_print_hex:
    mov bx, _HEX_OUT
    call print
    popa
    ret

_HEX_OUT:    db '0x0000', 0
