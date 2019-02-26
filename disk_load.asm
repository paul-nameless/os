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

    jc _disk_load_error       ; Jump if error ( i.e. carry flag set )

    pop dx              ; Restore DX from the stack
    cmp dh, al         ; if AL ( sectors read ) != DH ( sectors expected )
    jne _disk_load_error      ;   display error message
    popa
    ret

_disk_load_error:
    mov bx, _DISK_ERROR_MSG
    call print
    popa
    ret
    ;; jmp $

  ; Variables
_DISK_ERROR_MSG: db "Disk read error !", 0
