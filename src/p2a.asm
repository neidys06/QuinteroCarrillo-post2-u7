; p2a.asm - INT 16h: leer scan codes
; Compilar: nasm -f bin p2a.asm -o ../bin/p2a.com
ORG 100h

section .data
    prompt  db "Pulse una tecla (ESC para salir): $"
    msgScan db " Scan: $"
    msgAsc  db " ASCII: $"
    crlf    db 0Dh, 0Ah, "$"

section .text
start:
    mov ah, 09h
    mov dx, prompt
    int 21h

.leer:
    mov ah, 00h
    int 16h
    mov bl, ah
    mov bh, al

    cmp bl, 01h
    je .fin

    mov ah, 09h
    mov dx, msgScan
    int 21h
    mov al, bl
    call impHex

    mov ah, 09h
    mov dx, msgAsc
    int 21h
    mov al, bh
    call impHex

    mov ah, 09h
    mov dx, crlf
    int 21h
    jmp .leer

.fin:
    mov ah, 4Ch
    xor al, al
    int 21h

impHex:
    push ax
    shr al, 4
    call nibbleToChar
    mov dl, al
    mov ah, 02h
    int 21h
    pop ax
    and al, 0Fh
    call nibbleToChar
    mov dl, al
    mov ah, 02h
    int 21h
    ret

nibbleToChar:
    cmp al, 9
    jle .digit
    add al, 37h
    ret
.digit:
    add al, 30h
    ret