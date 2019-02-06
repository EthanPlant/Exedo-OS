mov ah, 0x0e ;  Tty mode
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; Print 'l' twice
mov al, 'o'
int 0x10

jmp $ ; Jump to current address (infinite loop)

; padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55