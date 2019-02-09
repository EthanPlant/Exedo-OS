[org 0x7c00] ; Bootsector offset
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl ; The BIOS sets us the boot drive in dl on boot
mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print
call print_nl

call load_kernel ; Read the kernel from disk
call switch_to_pm ; Switch to 32 bit protected mode
jmp $

%include "boot/print.asm"
%include "boot/print_hex.asm"
%include "boot/disk.asm"
%include "boot/gdt.asm"
%include "boot/32bit_print.asm"
%include "boot/switch_pm.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET
    mov dh, 16 ; Our future kernel will be large, make this big
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; Give control to the kernel
    jmp $ ; Stay here when the kernel gives control back to us (if ever)

BOOT_DRIVE db 0 ; It's a good idea to store in memory because dl may get overwritten
MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

; Padding
times 510 - ($-$$) db 0
dw 0xaa55