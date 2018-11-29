section .data                     ;se definen los datos
        text db "Hello World", 10 ;10 es el caracter de cambio de linea
section .text                     ;aqui es donde va el codigo
        global _start
_start:
        mov rax,1     ;id de sys_write
        mov rdi,1     ;standard ouput
        mov rsi,text  ;se carga el texto a rsi
        mov rdx,12    ;longitud de la cadena
        syscall       ;llamada al sistema

        mov rax,60    ;se termina la ejecucion del programa
        mov rdi,0     ;no hay codigo de error
        syscall       ;llamada al sistema