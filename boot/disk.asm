disk_load:
    pusha
    ; Reading from disk requires setting specific values in all registers
    ; So we save our input parameters from dx to the stack for later use
    push dx

    mov ah, 0x02 ; ah = int 0x13 function, 0x02 = read
    mov al, dh ; al = number of sectors to read
    mov cl, 0x02 ; cl = sector (0x02 is the first available sector)
    mov ch, 0x00 ; ch = cylinder
    mov dh, 0x00 ; dh = head number

    int 0x13 ; BIOS interrupt
    jc disk_error ; if error (stored in cary bit)

    pop dx
    cmp al, dh ; BIOS sets al to number of sectors read
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah ; ah = error code 
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0