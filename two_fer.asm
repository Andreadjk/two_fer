section .data
Text: db "One for X, one for me.",0h
you: db "you",0h
section .text
global two_fer
two_fer:       
                mov r10,0
                call strlen_arg_1
                mov r11,Text
                mov r12,0
                mov r13,0
                mov r14,0
                mov r15,0
                call string_copy
                mov rsi,rax
ret 
string_copy:
                cmp byte[r11 + r12 * 1],0h
                je exit_string_copy
                cmp byte[r11 + r12 * 1],58h
                je replace_x_to_name
                mov byte bl, [r11 + r12 * 1]
                mov byte[rax + r13 * 1],bl
                inc r12
                inc r13
                jmp string_copy
        replace_x_to_name:
                call convert_x_to_name
                inc r12
                jmp string_copy
        exit_string_copy:
                mov byte[rax + r13 * 1],0h
ret
strlen_arg_1:
                cmp rdi,0h
                je  exit_strlen
        count_chars:
                cmp byte [rdi + r10 * 1],0h
                je exit_strlen
                inc r10
                jmp count_chars
        exit_strlen:
ret
convert_x_to_name:
                mov r14,0
                cmp r10,0
                je write_you
        write_arg_1:
                cmp r14,r10
                je exit
                mov byte bl,[rdi + r14 * 1]
                mov byte[rax + r13 * 1],bl
                inc r13
                inc r14
                jmp write_arg_1
        write_you:      
                mov r15,you
        continue_you:
                cmp r14,2
                jg exit
                mov byte bl,[r15 + r14 * 1]
                mov byte[rax + r13 * 1],bl
                inc r13
                inc r14
                jmp continue_you
        exit:
ret
