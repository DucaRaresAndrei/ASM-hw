
section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ; through eax and ebx we save the index of each of the 4 positions

    ; in edx we save the number corresponding to the position in
    ; the matrix given by eax and ebx

    ; through the cmp instructions, it checks if
    ; that position exists in the matrix
diag_left_up:

    ; we check if the position on the upper left diagonal is available
    add eax, 1
    sub ebx, 1

    cmp eax, 7
    jg diag_right_up

    cmp ebx, 0
    jl diag_right_up

    xor edx, edx
    mov edx, eax
    imul edx, 8
    add edx, ebx
    mov byte [ecx + edx], 1    ; if the position exists, we store 1
                               ; in the array at that position
diag_right_up:

    ; we check if the position on the upper right diagonal is available
    add ebx, 2

    cmp eax, 7
    jg diag_right_down

    cmp ebx, 7
    jg diag_right_down

    xor edx, edx
    mov edx, eax
    imul edx, 8
    add edx, ebx
    mov byte [ecx + edx], 1    ; if the position exists, we store 1
                               ; in the array at that position
diag_right_down:

    ; we check if the position on the lower right diagonal is available
    sub eax, 2

    cmp eax, 0
    jl diag_left_down

    cmp ebx, 7
    jg diag_left_down

    xor edx, edx
    mov edx, eax
    imul edx, 8
    add edx, ebx
    mov byte [ecx + edx], 1    ; if the position exists, we store 1
                               ; in the array at that position
diag_left_down:

    ; we check if the position on the lower left diagonal is available
    sub ebx, 2

    cmp eax, 0
    jl exit

    cmp ebx, 0
    jl exit

    xor edx, edx
    mov edx, eax
    imul edx, 8
    add edx, ebx
    mov byte [ecx + edx], 1    ; if the position exists, we store 1
                               ; in the array at that position
exit:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY