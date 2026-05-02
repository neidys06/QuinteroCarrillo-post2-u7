; p2d.asm - Mini editor: INT 16h + B800h
; Compilar: nasm -f bin p2d.asm -o ../bin/p2d.com
ORG 100h

FILA     equ 12
COL_INI  equ 0
ATRIB    equ 0Fh

section .text
start:
    mov ax, 0B800h
    mov es, ax
    mov dl, COL_INI

.leer:
    mov ah, 00h
    int 16h
    mov cl, al
    mov ch, ah

    cmp cl, 0Dh
    je .fin

    or cl, cl
    jz .leer

    ; Calcular offset = (FILA*80 + col)*2
    movzx bx, dl
    mov ax, FILA
    mov si, 80
    mul si
    add ax, bx
    shl ax, 1
    mov di, ax

    ; Escribir caracter y atributo
    mov byte [es:di],   cl
    mov byte [es:di+1], ATRIB

    inc dl
    cmp dl, 80
    jl .leer
    mov dl, COL_INI
    jmp .leer

.fin:
    mov ah, 4Ch
    xor al, al
    int 21h