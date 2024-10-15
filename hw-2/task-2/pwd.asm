section .data
	back db "..", 0
	curr db ".", 0
	slash db "/", 0
	; declare global vars here

section .text
	global pwd

;;	void pwd(char **directories, int n, char *output)
;	Adauga in parametrul output path-ul rezultat din
;	parcurgerea celor n foldere din directories
pwd:
	enter 0, 0
	pusha

    mov esi, [ebp + 8]  ;adresa vectorului de foldere
    mov ecx, [ebp + 12] ;numărul de foldere
    mov edi, [ebp + 16] ;adresa noului sir

    mov byte [edi], '/' ;adaug radacina
    add edi, 1

	xor edx, edx
loop:
	cmp edx, ecx	;se verifica daca am parcurs toate directoarele
    je exit

    mov ebx, [esi + edx * 4]    ;adresa directorului curent
	inc edx

	push edx	;salvam edx pe stiva pentru a putea folosi
				;registrul la compararea stringurilor

	mov al, byte [curr]
	mov edx, ebx	

	cmp [edx], al	;verific daca este vorba de o comanda speciala
					;sau un director real
	jne continue_loop	;sar la adaugarea directorului
	
	inc edx
	cmp byte [edx], 0	
	je current_pop_edx	;ramanem la directorul curent
	
	mov al, byte [back + 1]
	cmp byte [edx], al	;verific daca este vorba de directorul parinte sau nu
	jne continue_loop	;sar la adaugarea directorului

	inc edx
	cmp byte [edx], 0	
	je parent_pop_edx	;trebuie sa ajung in directorul parnte

continue_loop:
	pop edx
	xor eax, eax

add_folder:
    mov al, [ebx]	;adaugam pe rand directorul, caracter cu caracter

    cmp al, 0	;verific daca am ajuns la finalul numelui directorului
    je help_add

    mov [edi], al	;adaugam caracterele din numele directorului
					;in stringul nostru

    inc edi
    inc ebx
    jmp add_folder

help_add:
	mov byte [edi], '/'	;adaugam '/' dupa directorul curent
	inc edi
	jmp loop_continue

;ramanem in directorul curent
current_pop_edx:
	pop edx
	jmp loop_continue

;cazul in care nu avem niciun director adaugat
not_a_single_directory:
	inc edi
help_parent:
	inc edi
loop_continue:
    jmp loop

parent_pop_edx:
	pop edx

	dec edi
	dec edi
	
	cmp byte [edi], 0	;verific daca mai avem si alte directoare adaugate
	je not_a_single_directory

	inc edi
	mov byte [edi], 0	;sterg din string '/' asociat directorului ce trebuie
						;eliminat
parent_directory:
	dec edi

	mov al, byte [slash] 
	cmp byte [edi], al	;verific daca am ajuns in radacina directorului
	je help_parent

    mov byte [edi], 0	;eliminam pe rand directorul din string

    jmp parent_directory

exit:
	popa
    leave
    ret