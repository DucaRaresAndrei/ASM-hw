%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;
struc avg
    .quo: resw 1
    .remain: resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    sub ebx, 1
Through_vector:

    mov esi, ebx
    imul esi, proc_size    ; esi holds the position of the
                           ; structure in the vector
    mov dl, [ecx + esi + proc.prio]    ; through dl it checks which of
                                       ; the 5 priorities the current
                                       ; structure has

    ; dx keeps the execution time of the current structure and adds it
    ; to the help vector for the sum of times

    ; it increases by 1 the value in the help vector to keep track of
    ; the number of structures with the same priority
Compare_1:

    cmp dl, 1
    jne Compare_2

    mov dx, [ecx + esi + proc.time]
    add word [time_result], dx

    add word [prio_result],  1

    jmp Exit_vector
Compare_2:

    cmp dl, 2
    jne Compare_3

    mov dx, [ecx + esi + proc.time]
    add word [time_result + 4], dx

    add word [prio_result + 4],  1

    jmp Exit_vector
Compare_3:

    cmp dl, 3
    jne Compare_4

    mov dx, [ecx + esi + proc.time]
    add word [time_result + 8], dx

    add word [prio_result + 8],  1

    jmp Exit_vector
Compare_4:

    cmp dl, 4
    jne Compare_5

    mov dx, [ecx + esi + proc.time]
    add word [time_result + 12], dx
    
    add word [prio_result + 12],  1

    jmp Exit_vector
Compare_5:

    mov dx, [ecx + esi + proc.time]
    add word [time_result + 16], dx
    
    add word [prio_result + 16],  1


Exit_vector:

    sub ebx, 1  ; through ebx we go through the indexes
                ; in the vector of structures
    cmp ebx, 0
    jge Through_vector

    xor esi, esi    ; esi retains the new index of the elements
                    ; of the help vectors
Vector_avg:

    mov bx, [prio_result + 4 * esi]    ; bx saves the number of
                                       ; structures that had the
                                       ; current priority
    cmp bx, 0   ; it checks that no division by 0 is done
    je End_function

    push eax

    mov edx, [time_result + 4 * esi]    ; edx saves the sum of
                                        ; execution times
    mov ax, dx
    shr edx, 16

    div bx  ; division is performed, which after saves the
            ; quatient in bx, and the rest in dx

    xor ebx, ebx
    mov bx, ax

    pop eax

    push esi
    imul esi, avg_size

    mov [eax + esi + avg.quo], bx
    mov [eax + esi + avg.remain], dx

    pop esi

End_function:

    add esi, 1

    cmp esi, 5
    jl Vector_avg
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY