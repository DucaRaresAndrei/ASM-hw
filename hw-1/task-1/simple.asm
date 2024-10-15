%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
    xor ebx, ebx    ; through this register the index
                    ; for all letters is passed

while:
    cmp ebx, ecx
    jge exit    ; the function has gone through all the letters,
                ; therefore the execution ends

    mov al, [esi + ebx]

    add al, dl

    cmp al, 'Z'
    jle not_circular    ; the letter on the position where the encryption
                        ; takes us does not exceed the letter Z

    sub al, 26  ; it performs the circular shift
not_circular:
    mov [edi + ebx], al    ; it stores the new letter on the 
                           ; corresponding position

    inc ebx
    jmp while
exit:
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
