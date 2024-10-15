%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    dec eax
My_sort:

    mov esi, eax    ; through esi we traverse the entire vector
                    ; of structures, esi keeping the current index
    dec esi
    push esi
    xor edi, edi

First_loop:

    imul esi, proc_size    ; the position in the vector with the
                           ; current index
    mov bl, [edx + esi + proc.prio]

    add esi, proc_size    ; the position in the vector with the
                          ; index higher by 1 than the current index
    mov cl, [edx + esi + proc.prio]

    sub esi, proc_size

    cmp bl, cl  ; check the order by priority
    jne Not_equal_prio
Equal_prio:

    mov bx, [edx + esi + proc.time]

    add esi, proc_size
    mov cx, [edx + esi + proc.time]

    sub esi, proc_size

    cmp bx, cx  ; check the order by time
    jne Not_equal_time
Equal_time:

    mov bx, [edx + esi + proc.pid]

    add esi, proc_size
    mov cx, [edx + esi + proc.pid]

    sub esi, proc_size

    cmp bx, cx  ; check the order by id
    jg Exchange
    jmp Skip_exchange
Not_equal_time:

    ; this part is executed only if the 2 structures have the same
    ; priority, but do not have the same execution time, and the
    ; order in the vector is checked
    cmp bx, cx
    jg Exchange
    jmp Skip_exchange    
Not_equal_prio:

    ; this part is executed only if the 2 structures do not have the
    ; same priority, and the order in the vector is checked
    cmp bl, cl
    jl Skip_exchange

Exchange:

    mov edi, 1

    ; the structures on positions i and i + 1 are exchanged,
    ; using the stack
    push word [edx + esi + proc.time]
    push word [edx + esi + proc.prio]
    push word [edx + esi + proc.pid]

    add esi, proc_size
    push word [edx + esi + proc.time]
    push word [edx + esi + proc.prio]
    push word [edx + esi + proc.pid]

    sub esi, proc_size
    pop word [edx + esi + proc.pid]
    pop word [edx + esi + proc.prio]
    pop word [edx + esi + proc.time]
     
    add esi, proc_size
    pop word [edx + esi + proc.pid]
    pop word [edx + esi + proc.prio]
    pop word [edx + esi + proc.time]
Skip_exchange:

    pop esi
    sub esi, 1
    push esi

    cmp esi, 0    ; check if a set of comparisons has finished
    jge First_loop

    pop esi
    test edi, edi   ; through edi we check if exchanges have been made.
                    ; the function stops when no structure is exchanged
                    ; with another
    jnz My_sort
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY