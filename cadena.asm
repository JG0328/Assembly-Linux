
section .data
        let1 db "Inserte una cadena: ", 10
        let2 db "Inserte el caracter a buscar: ", 10
        let3 db "Se repite: ", 10
        let4 db "Ascendente: "
        let5 db "Descendete: "
        let6 db "Es par", 10
        let7 db "Es impar", 10
        let8 db "Es primo", 10
        let9 db "Es compuesto", 10
        let10 db "Total de caracteres: "
        let11 db "El 1 no es primo ni compuesto", 10
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
        ;se imprime el total de caracteres que tiene la cadena
        call _obtenerTotalCaracteres
        ;se determina si el numero es par o impar, primo o compuesto
        call _determinarNumero

        call _printLet2
        call _obtenerCaracter

        mov rcx,0
        mov rdx,0
        call _contar
        
        push rcx
        call _printLet3
        pop rcx

        ;se imprime las veces que se repite el caracter
        push rcx
        mov rax,rcx
        call _printNum
        pop rcx

        ;se ordena la cadena de forma ascendente y descendente
        call _ordenar

        ;se terminar el programa
        mov rax,60
        mov rdi,0
        syscall

_determinarNumero:
        xor rbx,rbx ;rbx se inicializa en cero
        mov rbx,rcx ;muevo el numero a rbx para no interferir con las operaciones
        parImpar:
                mov rdx,0
                mov rax,rbx
                mov rcx,2
                div rcx ;rax contendra el cociente y rdx el residuo

                cmp rdx,0
                je esPar

                jmp esImpar
        esPar:
                push rax
                push rdi
                push rsi
                push rdx

                mov rax,1
                mov rdi,1
                mov rsi,let6
                mov rdx,7
                syscall

                pop rdx
                pop rsi
                pop rdi
                pop rax

                jmp primoCompuesto
        esImpar:
                push rax
                push rdi
                push rsi
                push rdx

                mov rax,1
                mov rdi,1
                mov rsi,let7
                mov rdx,9
                syscall

                pop rdx
                pop rsi
                pop rdi
                pop rax
        primoCompuesto:
                cmp rbx,1
                je excUno
                cmp rbx,2
                je esPrimo

                mov rsi,2
                jmp pcLoop
        pcLoop:
                cmp rbx,rsi
                je esPrimo

                mov rdx,0
                mov rax,rbx
                mov rcx,rsi
                div rcx ;rax contendra el cociente y rdx el residuo

                cmp rdx,0
                je esCompuesto

                inc rsi

                jmp pcLoop
        excUno:
                push rax
                push rdi
                push rsi
                push rdx

                mov rax,1
                mov rdi,1
                mov rsi,let11
                mov rdx,30
                syscall

                pop rdx
                pop rsi
                pop rdi
                pop rax

                jmp endDet
        esPrimo:
                push rax
                push rdi
                push rsi
                push rdx

                mov rax,1
                mov rdi,1
                mov rsi,let8
                mov rdx,9
                syscall

                pop rdx
                pop rsi
                pop rdi
                pop rax

                jmp endDet
        esCompuesto:
                push rax
                push rdi
                push rsi
                push rdx

                mov rax,1
                mov rdi,1
                mov rsi,let9
                mov rdx,13
                syscall

                pop rdx
                pop rsi
                pop rdi
                pop rax
        endDet:
                ret

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
                push rcx
                mov rax,rcx
                call _printNum
                pop rcx
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
        mov rdi,buffCadena    ;se mueve la cadena a rdi para luego acceder a ella caracter por caracter
        mov al,[buffCaracter] ;se mueve a al el caracter

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

;funcion que imprime un cambio de linea
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
