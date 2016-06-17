section .text
global _start
_start:
	push A
	call LerInteiro
	add esp,4
	push B
	call LerInteiro
	add esp,4
	push C
	call LerInteiro
	add esp,4
	mov eax, [A]
	sub eax, [B]
	cmp eax, 0
	je CHECK_B
	mov eax, [A]
	sub eax, [C]
	cmp eax, 0
	je CHECK_B
	jmp A_WINS
CHECK_B: 
	mov eax, [ZERO]
	mov eax, [B]
	sub eax, [A]
	cmp eax, 0
	je CHECK_C
	mov eax, [B]
	sub eax, [C]
	cmp eax, 0
	je CHECK_C
	jmp B_WINS
CHECK_C: 
	mov eax, [ZERO]
	mov eax, [C]
	sub eax, [A]
	cmp eax, 0
	je TIE
	mov eax, [C]
	sub eax, [B]
	cmp eax, 0
	je TIE
	jmp C_WINS
TIE: 
	mov eax, [ZERO]
	push DWORD [ZERO]
	call EscreverInteiro
	add esp,4
	mov eax,1
	mov ebx,0
	int 80h
A_WINS: 
	mov eax, [ZERO]
	push DWORD [ONE]
	call EscreverInteiro
	add esp,4
	mov eax,1
	mov ebx,0
	int 80h
B_WINS: 
	mov eax, [ZERO]
	push DWORD [TWO]
	call EscreverInteiro
	add esp,4
	mov eax,1
	mov ebx,0
	int 80h
C_WINS: 
	mov eax, [ZERO]
	push DWORD [THREE]
	call EscreverInteiro
	add esp,4
	mov eax,1
	mov ebx,0
	int 80h
section .data
	A dd 0
	B dd 0
	C dd 0
	ZERO dd 0
	ONE dd 1
	TWO dd 2
	THREE dd 3


section .text
LerInteiro:
	enter 5,0
	push eax
	push ebx
	push ecx
	push edx
	mov ebx,ebp
	sub ebx,1
	mov dword [EBP-5],0
lerI:
	push ebx
	call LerChar
	add esp,4
	cmp byte [EBP-1],0xa
	je fim
	mov eax, [EBP-5]
	mov edx,eax
	shl eax,2
	add eax,eax
	add eax,edx
	add eax,edx
	mov [EBP-5],eax
	mov eax,[EBP-1]
	sub eax,0x30
	add [EBP-5],eax
	jmp lerI
fim:
	mov eax,[EBP-5]
	mov ebx,[EBP+8]
	mov [ebx],eax 
	pop edx
	pop ecx
	pop ebx
	pop eax
	leave
	ret
EscreverInteiro:
	enter 0,0
	push eax
	push ecx
	push edx
	mov eax,[EBP+8]
	mov edx,0
	push edx
	mov ecx,10
while:
	mov edx,0
	div ecx
	add edx,0x30
	push edx
	cmp eax,0
	jnz while
	push esp
	call EscreverString
	add esp,4
	pop edx
	pop ecx
	pop eax
	leave
	ret
LerString:
	enter 0,0
	push ebx
	push ecx
	mov eax,0
ler:
	mov ecx,[EBP+8]
	mov ebx,eax
	shl ebx,2
	add ecx,ebx
	push ecx
	call LerChar
	inc eax
	cmp dword [ecx],0xa
	jne ler
	add esp,4
	mov dword [ecx],0
	pop ecx
	pop ebx
	leave
	ret
EscreverString:
	enter 0,0
	push eax
	mov eax,[EBP+8]
escreve:
	push eax
	call EscreverChar
	add esp,4
	add eax,4
	cmp dword [eax],0
	jnz escreve
	pop eax
	leave
	ret
LerChar:
	enter 0,0
	push eax
	push ebx
	push ecx
	push ebx
	mov eax, 3
	mov ebx, 0
	mov ecx, [EBP+8] 
	mov edx, 1
	int 80h
	pop edx
	pop ecx
	pop ebx
	pop eax
	leave
	ret
EscreverChar:
	enter 0,0
	push eax
	push ebx
	push ecx
	push ebx
	mov eax,4
	mov ebx,1
	mov ecx,[EBP+8]
	mov edx,1
	int 80h
	pop edx
	pop ecx
	pop ebx
	pop eax
	leave
	ret
