section .text
global _start
_start:
	push A
	call LerString
	add esp,4
	mov [B], eax
	push DWORD [B]
	call EscreverInteiro
	add esp,4
	push H
	call LerInteiro
	add esp,4
	mov eax, [H]
	sub eax, [H]
	mov [B], eax
	push DWORD [B]
	call EscreverInteiro
	add esp,4
	mov [B], eax
	push DWORD [B]
	call EscreverInteiro
	add esp,4
	push B
	call LerInteiro
	add esp,4
	mov [B], eax
	push DWORD [B]
	call EscreverInteiro
	add esp,4
	cmp eax, 0
	je ZERO
VOLTA: 
	add eax, [U]
	mov [B], eax
	push DWORD [B]
	call EscreverInteiro
	add esp,4
	push DWORD [B]
	call EscreverInteiro
	add esp,4
	push DWORD [B]
	call EscreverInteiro
	add esp,4
	push DWORD A
	call EscreverString
	add esp,4
	cmp eax, 0
	jg UM
V2: 
	sub eax, [G]
	mov [B], eax
	push DWORD [B]
	call EscreverInteiro
	add esp,4
	push DWORD A
	call EscreverString
	add esp,4
	cmp eax, 0
	jl DOIS
ZERO: 
	push DWORD [Z]
	call EscreverInteiro
	add esp,4
	jmp VOLTA
	jmp EXIT
UM: 
	push DWORD [U]
	call EscreverInteiro
	add esp,4
	jmp V2
	jmp EXIT
DOIS: 
	push DWORD [D]
	call EscreverInteiro
	add esp,4
EXIT: 
	mov eax,1
	mov ebx,0
	int 80h
section .data
	H dd 0,0,0,0
	B dd 0
	A dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	G dd 5
	Z dd 0
	U dd 1
	D dd 2


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
	push ebx
	push ecx
	push edx
	mov ebx,esp
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
	mov esp,ebx
	pop edx
	pop ecx
	pop ebx
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
	add esp,4
	inc eax
	cmp dword [ecx],0xa
	jne ler
	mov dword [ecx],0
	pop ecx
	pop ebx
	dec eax
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
	push edx
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
	push edx
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
