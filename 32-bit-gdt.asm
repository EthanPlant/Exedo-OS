gdt_start:
    ; The GDT starts with a null 8-byte
    dd 0x0 ; 4 byte
    dd 0x0 ; 4 Byte

gdt_code:
    dw 0xffff ; Segment length
    dw 0x0 ; Segment base (bits 0-15)
    db 0x0 ; Segment base (bits 16-23)
    db 10011010b ; Flags
    db 11001111b ; Flags + segment length
    db 0x0 ; Segment base (bits 24-31)

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; Size, always 1 less than its true size
    dd gdt_start ; Address

; Define some constants
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start