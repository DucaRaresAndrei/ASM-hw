section .data

section .text
    global bonus

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ; [ecx] stores the first number in the vector,
    ; representing the upper part of the matrix

    ; [ecx + 4] stores the second number in the vector,
    ; representing the lower part of the matrix

    ; through eax and ebx we save the index of each of the 4 positions

    ; through the first 2 cmp instructions of each diagonal function,
    ; it checks if that position exists in the matrix

    ; through the third command cmp from the diagonal functions checks
    ; if the position is on the upper or lower part of the matrix

    ; in edx we save the number corresponding to the position in
    ; the matrix given by eax and ebx
diag_left_up:
    add eax, 1
    sub ebx, 1

    cmp eax, 7
    jg diag_right_up

    cmp ebx, 0
    jl diag_right_up

    xor edx, edx
    mov edx, eax
    shl edx, 3
    add edx, ebx

    cmp eax, 3
    jg left_up_0    ; according to the result, we set the bit only in
                    ; the number corresponding to the lower/upper part
                    ; of the matrix

    mov esi, [ecx + 4]
    bts esi, edx
    mov [ecx + 4], esi
    jmp diag_right_up
left_up_0:

    ; if the position is part of the upper part of the matrix, we must
    ; subtract 32 from its value, to set the correct bit in the first
    ; element of the vector. Thus we skip the 32 bits from the lower part

    sub edx, 32
    mov esi, [ecx]
    bts esi, edx
    mov [ecx], esi
diag_right_up:

    add ebx, 2

    cmp eax, 7
    jg diag_right_down

    cmp ebx, 7
    jg diag_right_down

    xor edx, edx
    mov edx, eax
    shl edx, 3
    add edx, ebx

    cmp eax, 3
    jg right_up_0    ; according to the result, we set the bit only in
                     ; the number corresponding to the lower/upper part
                     ; of the matrix

    mov esi, [ecx + 4]
    bts esi, edx
    mov [ecx + 4], esi
    jmp diag_right_down
right_up_0:

    ; if the position is part of the upper part of the matrix, we must
    ; subtract 32 from its value, to set the correct bit in the first
    ; element of the vector. Thus we skip the 32 bits from the lower part
    
    sub edx, 32
    mov esi, [ecx]
    bts esi, edx
    mov [ecx], esi
diag_right_down:

    sub eax, 2

    cmp eax, 0
    jl diag_left_down

    cmp ebx, 7
    jg diag_left_down

    xor edx, edx
    mov edx, eax
    shl edx, 3
    add edx, ebx

    cmp eax, 3
    jg right_down_0    ; according to the result, we set the bit only in
                       ; the number corresponding to the lower/upper part
                       ; of the matrix

    mov esi, [ecx + 4]
    bts esi, edx
    mov [ecx + 4], esi
    jmp diag_left_down
right_down_0:

    ; if the position is part of the upper part of the matrix, we must
    ; subtract 32 from its value, to set the correct bit in the first
    ; element of the vector. Thus we skip the 32 bits from the lower part
    
    sub edx, 32
    mov esi, [ecx]
    bts esi, edx
    mov [ecx], esi
diag_left_down:

    sub ebx, 2

    cmp eax, 0
    jl exit

    cmp ebx, 0
    jl exit

    xor edx, edx
    mov edx, eax
    shl edx, 3
    add edx, ebx

    cmp eax, 3
    jg left_down_0    ; according to the result, we set the bit only in
                      ; the number corresponding to the lower/upper part
                      ; of the matrix

    mov esi, [ecx + 4]
    bts esi, edx
    mov [ecx + 4], esi
    jmp exit
left_down_0:

    ; if the position is part of the upper part of the matrix, we must
    ; subtract 32 from its value, to set the correct bit in the first
    ; element of the vector. Thus we skip the 32 bits from the lower part
    
    sub edx, 32
    mov esi, [ecx]
    bts esi, edx
    mov [ecx], esi
exit:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY