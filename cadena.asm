section .data
        let1 db "Inserte una cadena: ", 10
        let2 db "Inserte el caracter a buscar: ", 10
        let3 db "Se repite: ", 10
section .bss
        buffCadena resb 50
        buffCaracter resb 1
        digitSpace resb 100
        digitSpacePos resb 8
section .text
        global _start
_start:
        call _printLet1
        call  _obtenerCadena
        call _printLet2
        call _obtenerCaracter

        ;mov rsi, buffCaracter
        ;mov rdi, [buffCadena]
        call _contar
        
        call _printLet3

        mov rax,rcx
        ;call _printNum

        mov rax,60
        mov rdi,0
        syscall

_contar:
        mov rbx,buffCadena
        mov rsi, [rbx]
        mov rax,1
        mov rdi,1
        mov rdx,21
        syscall
        ret

_printNum:
        mov rcx,digitSpace
        mov rbx,10
        mov [rcx],rbx
        inc rcx
        mov [digitSpacePos],rcx

_printNumLoop:
        mov rdx,0
        mov rbx,10
        div rbx
        push rax
        add rdx,48

        mov rcx,[digitSpacePos]
        mov [rcx],dl
        inc rcx
        mov [digitSpacePos],rcx

        pop rax
        cmp rax,0
        jne _printNumLoop

_printNumLoop2:
    mov rcx,[digitSpacePos]
    mov rax,1
    mov rdi,1
    mov rsi,rcx
    mov rdx,1
    syscall

    mov rcx,[digitSpacePos]
    dec rcx
    mov [digitSpacePos],rcx

    cmp rcx,digitSpace
    jge _printNumLoop2

    ret
_obtenerCadena:
        mov rax,0
        mov rdi,0
        mov rsi,buffCadena
        mov rdx,50
        syscall
        ret

_obtenerCaracter:
        mov rax,0
        mov rdi,0
        mov rsi,buffCaracter
        mov rdx,1
        syscall
        ret

_printLet1:
        mov rax,1
        mov rdi,1
        mov rsi,let1
        mov rdx,21
        syscall
        ret

_printLet2:
        mov rax,1
        mov rdi,1
        mov rsi,let2
        mov rdx,31
        syscall
        ret

_printLet3:
        mov rax,1
        mov rdi,1
        mov rsi,let3
        mov rdx,12
        syscall
        ret