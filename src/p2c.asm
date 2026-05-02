; p2c.asm - Limpiar pantalla con REP STOSW en B800h
; Compilar: nasm -f bin p2c.asm -o ../bin/p2c.com
ORG 100h

section .text
start:
    ; Apuntar ES a B800h
    mov ax, 0B800h
    mov es, ax

    ; Rellenar pantalla completa con fondo azul
    ; AH = atributo 17h (azul fondo, blanco texto)
    ; AL = 20h (espacio ASCII)
    mov ax, 1720h
    xor di, di
    mov cx, 2000
    cld
    rep stosw

    ; Escribir mensaje en fila 12, col 30
    ; offset = (12*80+30)*2 = 1980
    mov di, 1980
    mov si, titulo

.bucle:
    lodsb
    or al, al
    jz .fin
    mov ah, 0Fh
    stosw
    jmp .bucle

.fin:
    mov ah, 07h
    int 21h
    mov ah, 4Ch
    xor al, al
    int 21h

titulo: db "HOLA DESDE B800h", 0