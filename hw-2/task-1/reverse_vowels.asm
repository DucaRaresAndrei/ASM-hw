section .data
	; declare global vars here
	vowels db 'aeiou', 0
section .text
    global reverse_vowels
    extern strchr
;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place

reverse_vowels:
	push ebp
    push esp
    pop ebp

    xor edx, edx    ;numarul de vocale

    push dword [ebp + 8]
    pop edi     ;adresa stringului dat ca parametru

    push dword [ebp + 8]
    pop ecx     ;adresa stringului dat ca parametru

add_vowels:
    push dword [edi]
    pop eax     ;caracterul curent

    cmp eax, 0  ;verificam daca am ajuns la finalul stringului
    je continue

    push dword ecx
    push eax
    push vowels
    call strchr
    add esp, 8  ;restabilesc stiva
    pop ecx

    inc edi

    test eax, eax   ;verific daca este vocala
    jz add_vowels

    push dword [eax]    ;adaug in stiva vocalele
    inc edx     ;creste numarul de vocale
    jmp add_vowels

continue:
    cmp edx, 0      ;verificam daca avem vocale pe stiva
    je exit

    push dword ecx
    pop edi     ;preiau adresa de inceput a sirului

change_vowels:
    push dword [edi]
    pop eax     ;caracterul curent

    cmp eax, 0  ;verificam daca am ajuns la finalul stringului
    je exit

    push eax
    push vowels
    call strchr
    add esp, 8  ;restabilesc stiva

    test eax, eax   ;verific daca este vocala
    jz help_change

    pop ecx     ;valoarea vocalei corespunzatoare parcurgerii invers
    push dword [eax]
    pop eax     ;valoarea vocalei corespunzatoare parcurgerii normale
    sub ecx, eax    ;aflam diferenta dintre cele 2 vocale
    add byte [edi], cl     ;actualizam vocala, adunand diferenta
                           ;calculata mai sus

    inc edi
    jmp change_vowels

help_change:
    inc edi
    jmp change_vowels

exit:
    pop ebp
    ret