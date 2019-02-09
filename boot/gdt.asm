gdt_start:
    ; The GDT starts with a null 8-byte
    dd 0x0 ; 4 byte
    dd 0x0 ; 4 byte

; GDT for code segment
gdt_code:
    dw 0xffff ; Segment length (bits 0-15)
    dw 0x0 ; Segment base (bits 0-15)
    db 0x0 ; Segment base (bits 16-23)
    db 10011010b ; Flags 
    db 11001111b ; Flags + segment length (bits 16-19)
    db 0x0

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; Size 
    dd gdt_start ; Address

; Constants for later use
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start