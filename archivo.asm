
section .data
        let1 db "Inserte el nombre del archivo, con su extension: "
        clear db "./clear", 0
section .bss
        buffArchivo resb 50    ;nombre del archivo, con su extension
        buffLectura resb 20480 ;se permite la lectura de hasta 20KB
section .text
        global _start
_start:
        ;se imprime let1
        mov rax,1
        mov rdi,1
        mov rsi,let1
        mov rdx,49
        syscall

        ;se captura el nombre del archivo
        mov rax,0
        mov rdi,0
        mov rsi,buffArchivo
        mov rdx,50
        syscall

        call _deleteNewLine

        ;se abre el archivo
        mov rax,5 ;abrir
        mov rbx,buffArchivo
        mov rcx,0 ;solo lectura
        int 80h

        ;se lee el archivo
        mov rax,3 ;leer
        mov rbx,rax
        mov rcx,buffLectura
        mov rdx,20480
        int 80h

        ;se escribe al buffer
        mov rax,4 ;escribir
        mov rbx,1
        mov rcx,buffLectura
        mov rdx,20480
        int 80h

        ;se cierra el archivo
        mov rax,6 ;cerrar
        int 80h

        ;se imprime el archivo
        mov rax,1
        mov rdi,1
        mov rsi,buffLectura
        mov rdx,20480
        int 80h

        ;se termina el programa
        mov rax,60
        mov rdi,0
        syscall
            

_deleteNewLine:
        mov rsi,buffArchivo
        mov rdi,0

        dnlLoop:
                mov ah,[rsi]
                cmp ah,10
                je delChar

                inc rsi
                inc rdi

                jmp dnlLoop
        delChar:
                mov byte[buffArchivo+rdi],0
        endLoop:
                ret
