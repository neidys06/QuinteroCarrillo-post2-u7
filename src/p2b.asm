; p2b.asm - Escritura directa en B800h
; Compilar: nasm -f bin p2b.asm -o ../bin/p2b.com
; offset = (fila*80 + col)*2
ORG 100h

section .text
start:
    ; Apuntar ES al segmento de video B800h
    mov ax, 0B800h
    mov es, ax

    ; "H" blanco brillante - fila 10, col 35
    ; offset = (10*80+35)*2 = 1670
    mov di, 1670
    mov byte [es:di],   48h
    mov byte [es:di+1], 0Fh

    ; "O" amarillo - fila 11, col 35
    ; offset = (11*80+35)*2 = 1830
    mov di, 1830
    mov byte [es:di],   4Fh
    mov byte [es:di+1], 0Eh

    ; "L" verde claro - fila 12, col 35
    ; offset = (12*80+35)*2 = 1990
    mov di, 1990
    mov byte [es:di],   4Ch
    mov byte [es:di+1], 0Ah

    ; "A" rojo claro - fila 13, col 35
    ; offset = (13*80+35)*2 = 2150
    mov di, 2150
    mov byte [es:di],   41h
    mov byte [es:di+1], 0Ch

    ; Esperar tecla y salir
    mov ah, 07h
    int 21h
    mov ah, 4Ch
    xor al, al
    int 21h