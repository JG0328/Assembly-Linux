section .data
        let1 db "Inserte una cadena: ", 10
        let2 db "Inserte el caracter a buscar: ", 10
        let3 db "Se repite: ", 10
        let4 db "Ascendente: "
        let5 db "Descendete: "
        let6 db "Es par"
        let7 db "Es impar"
        let8 db "Es primo"
        let9 db "Es compuesto"
        let10 db "Total de caracteres: "
        newLine db "", 10
        ordAs db "ABCDEFGHIJKLMNOPQRSTUVWXYZ$"
        ordDes db "ZYXWVUTSRQPONMLKJIHGFEDCBA$"
section .bss
        buffCadena resb 50
        buffCaracter resb 1
        digitSpace resb 100
        digitSpacePos resb 8
section .text
        global _start
_start:
        call _printLet1
        call _obtenerCadena

        call _printLet10
        mov rcx,0
        mov rdx,0
        mov rdx,buffCadena
        call _obtenerTotalCaracteres

        call _printLet2
        call _obtenerCaracter

        mov rcx,0
        mov rdx,0
        call _contar
        
        push rcx
        call _printLet3
        pop rcx

        push rcx
        mov rax,rcx
        call _printNum
        pop rcx

        call _ordenar

        mov rax,60
        mov rdi,0
        syscall

_obtenerTotalCaracteres:
        totalLoop:
                mov ah,[rdx]
                
                inc rcx
                inc rdx

                cmp ah,10
                je decRCX

                jmp totalLoop
        decRCX:
                dec rcx
                jmp printTotalChars
        printTotalChars:
                mov rax,rcx
                call _printNum
                ret
_ordenar:
        call _printLet4

        mov rdi,buffCadena
        mov rsi,ordAs
        mov rdx,0

        ascLoop:
                cmp rdx,50
                je ascReset

                mov ah,[rsi]
                mov al,[rdi]

                cmp ah,'$'
                je ascEnd

                cmp al,ah
                je ascPrintChar

                inc rdi
                inc rdx

                jmp ascLoop
        ascReset:
                mov rdx,0
                mov rdi,buffCadena
                inc rsi
                jmp ascLoop
        ascEnd:
                call _printNewLine
                mov rdi,buffCadena
                mov rsi,ordDes
                mov rdx,0
                call _printLet5
                jmp desLoop
        ascPrintChar:
                push rax
                push rdi
                push rdx
                push rsi

                mov rcx,rsi

                mov rax,1
                mov rdi,1
                mov rsi,rcx
                mov rdx,1
                syscall

                pop rsi
                pop rdx
                pop rdi
                pop rax

                jmp ascRetry
        ascRetry:
                inc rdi
                inc rdx

                jmp ascLoop
        desLoop:
                cmp rdx,50
                je desReset

                mov ah,[rsi]
                mov al,[rdi]

                cmp ah,'$'
                je sortEnd

                cmp al,ah
                je desPrintChar

                inc rdi
                inc rdx

                jmp desLoop
        desReset:
                mov rdx,0
                mov rdi,buffCadena
                inc rsi
                jmp desLoop
        desPrintChar:
                push rax
                push rdi
                push rdx
                push rsi

                mov rcx,rsi

                mov rax,1
                mov rdi,1
                mov rsi,rcx
                mov rdx,1
                syscall

                pop rsi
                pop rdx
                pop rdi
                pop rax

                jmp desRetry
        desRetry:
                inc rdi
                inc rdx

                jmp desLoop
        sortEnd:
                call _printNewLine
                ret
_contar:
        mov rdi,buffCadena
        mov al,[buffCaracter]

        contarLoop:
                mov ah,[rdi]
                cmp rdx,50
                je contarEnd
                cmp ah,al
                je incCont

                inc rdx
                inc rdi
                jmp contarLoop
        incCont:
                inc rcx
                inc rdi
                inc rdx
                jmp contarLoop
        contarEnd:
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
_printLet4:
        mov rax,1
        mov rdi,1
        mov rsi,let4
        mov rdx,12
        syscall
        ret
_printLet5:
        push rax
        push rdi
        push rsi
        push rdx

        mov rax,1
        mov rdi,1
        mov rsi,let5
        mov rdx,12
        syscall

        pop rdx
        pop rsi
        pop rdi
        pop rax

        ret
_printLet10:
        push rax
        push rdi
        push rsi
        push rdx

        mov rax,1
        mov rdi,1
        mov rsi,let10
        mov rdx,21
        syscall

        pop rdx
        pop rsi
        pop rdi
        pop rax

        ret
_printNewLine:
        push rax
        push rdi
        push rsi
        push rdx

        mov rax,1
        mov rdi,1
        mov rsi,newLine
        mov rdx,1
        syscall
        
        pop rdx
        pop rsi
        pop rdi
        pop rax

        ret