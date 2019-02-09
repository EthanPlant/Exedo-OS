print_hex:
    pusha

    mov cx, 0 ; Our index variable

hex_loop:
    cmp cx, 4 ; Loop 4 times
    je end

    ; 1) Convert last char of dx to ASCII
    mov ax, dx ; We'll use ax as the working register
    and ax, 0x000f ; Mask the first 3  digits to zeroes
    add al, 0x30 ; Add 0x30 to convert to ASCII
    cmp al, 0x39 ; if > 9, add extra 8 to represent hex digits A - F
    jle step2
    add al, 7

step2:
    ; 2) Get the correct position of the string to place our ASCII char
    ; bx = base addr + str length - index of char
    mov bx, HEX_OUT + 5 ; base + length
    sub bx, cx ; Our index variable
    mov [bx], al ; Copy the ASCII char on al to the position pointed to by bx
    ror dx, 4

    ; Increment index and loop
    add cx, 1
    jmp hex_loop

end:
    ; Prepare the parameter and call the function
    mov bx, HEX_OUT
    call print

    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; Reserve memory for our new string