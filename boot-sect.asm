[org 0x7c00] ; Bootloader offset

    mov bp, 0x9000 ; Set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print ; This will be written after BIOS messages

    call switch_to_pm
    jmp $ ; This will never actually be executed

%include "boot-sect-print.asm"
%include "32-bit-gdt.asm"
%include "32-bit-print.asm"
%include "32-bit-switch.asm"

[bits 32]
BEGIN_PM: ; After the switch we get here
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; Bootsector
times 510 - ($-$$) db 0
dw 0xaa55