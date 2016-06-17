section .text
global _start
_start:
	mov ebx, [D]
	mov [SAIDA1], ebx
	mov ebx, [I]
	mov [SAIDA1+1*4], ebx
	mov ebx, [G]
	mov [SAIDA1+2*4], ebx
	mov ebx, [I]
	mov [SAIDA1+3*4], ebx
	mov ebx, [T]
	mov [SAIDA1+4*4], ebx
	mov ebx, [E]
	mov [SAIDA1+5*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+6*4], ebx
	mov ebx, [S]
	mov [SAIDA1+7*4], ebx
	mov ebx, [E]
	mov [SAIDA1+8*4], ebx
	mov ebx, [U]
	mov [SAIDA1+9*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+10*4], ebx
	mov ebx, [N]
	mov [SAIDA1+11*4], ebx
	mov ebx, [O]
	mov [SAIDA1+12*4], ebx
	mov ebx, [M]
	mov [SAIDA1+13*4], ebx
	mov ebx, [E]
	mov [SAIDA1+14*4], ebx
	mov ebx, [ENDL]
	mov [SAIDA1+15*4], ebx
	mov ebx, [FIM]
	mov [SAIDA1+16*4], ebx
	push DWORD SAIDA1
	call EscreverString
	add esp,4
	push RESPOSTA1
	call LerString
	add esp,4
	mov ebx, [D]
	mov [SAIDA1], ebx
	mov ebx, [I]
	mov [SAIDA1+1*4], ebx
	mov ebx, [G]
	mov [SAIDA1+2*4], ebx
	mov ebx, [I]
	mov [SAIDA1+3*4], ebx
	mov ebx, [T]
	mov [SAIDA1+4*4], ebx
	mov ebx, [E]
	mov [SAIDA1+5*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+6*4], ebx
	mov ebx, [S]
	mov [SAIDA1+7*4], ebx
	mov ebx, [U]
	mov [SAIDA1+8*4], ebx
	mov ebx, [A]
	mov [SAIDA1+9*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+10*4], ebx
	mov ebx, [I]
	mov [SAIDA1+11*4], ebx
	mov ebx, [D]
	mov [SAIDA1+12*4], ebx
	mov ebx, [A]
	mov [SAIDA1+13*4], ebx
	mov ebx, [D]
	mov [SAIDA1+14*4], ebx
	mov ebx, [E]
	mov [SAIDA1+15*4], ebx
	mov ebx, [ENDL]
	mov [SAIDA1+16*4], ebx
	mov ebx, [FIM]
	mov [SAIDA1+17*4], ebx
	push DWORD SAIDA1
	call EscreverString
	add esp,4
	push RESPOSTA2
	call LerInteiro
	add esp,4
	mov ebx, [D]
	mov [SAIDA1], ebx
	mov ebx, [I]
	mov [SAIDA1+1*4], ebx
	mov ebx, [G]
	mov [SAIDA1+2*4], ebx
	mov ebx, [I]
	mov [SAIDA1+3*4], ebx
	mov ebx, [T]
	mov [SAIDA1+4*4], ebx
	mov ebx, [E]
	mov [SAIDA1+5*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+6*4], ebx
	mov ebx, [S]
	mov [SAIDA1+7*4], ebx
	mov ebx, [U]
	mov [SAIDA1+8*4], ebx
	mov ebx, [A]
	mov [SAIDA1+9*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+10*4], ebx
	mov ebx, [L]
	mov [SAIDA1+11*4], ebx
	mov ebx, [E]
	mov [SAIDA1+12*4], ebx
	mov ebx, [T]
	mov [SAIDA1+13*4], ebx
	mov ebx, [R]
	mov [SAIDA1+14*4], ebx
	mov ebx, [A]
	mov [SAIDA1+15*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+16*4], ebx
	mov ebx, [F]
	mov [SAIDA1+17*4], ebx
	mov ebx, [A]
	mov [SAIDA1+18*4], ebx
	mov ebx, [V]
	mov [SAIDA1+19*4], ebx
	mov ebx, [O]
	mov [SAIDA1+20*4], ebx
	mov ebx, [R]
	mov [SAIDA1+21*4], ebx
	mov ebx, [I]
	mov [SAIDA1+22*4], ebx
	mov ebx, [T]
	mov [SAIDA1+23*4], ebx
	mov ebx, [A]
	mov [SAIDA1+24*4], ebx
	mov ebx, [ENDL]
	mov [SAIDA1+25*4], ebx
	mov ebx, [FIM]
	mov [SAIDA1+26*4], ebx
	push DWORD SAIDA1
	call EscreverString
	add esp,4
	push RESPOSTA3
	call LerInteiro
	add esp,4
	push DWORD RESPOSTA1
	call EscreverString
	add esp,4
	push DWORD SPACE
	call EscreverChar
	add esp,4
	mov ebx, [S]
	mov [SAIDA1], ebx
	mov ebx, [U]
	mov [SAIDA1+1*4], ebx
	mov ebx, [A]
	mov [SAIDA1+2*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+3*4], ebx
	mov ebx, [I]
	mov [SAIDA1+4*4], ebx
	mov ebx, [D]
	mov [SAIDA1+5*4], ebx
	mov ebx, [A]
	mov [SAIDA1+6*4], ebx
	mov ebx, [D]
	mov [SAIDA1+7*4], ebx
	mov ebx, [E]
	mov [SAIDA1+8*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+9*4], ebx
	mov ebx, [E]
	mov [SAIDA1+10*4], ebx
	mov ebx, [M]
	mov [SAIDA1+11*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+12*4], ebx
	mov ebx, [CINCO]
	mov [SAIDA1+13*4], ebx
	mov ebx, [ZERO]
	mov [SAIDA1+14*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+15*4], ebx
	mov ebx, [A]
	mov [SAIDA1+16*4], ebx
	mov ebx, [N]
	mov [SAIDA1+17*4], ebx
	mov ebx, [O]
	mov [SAIDA1+18*4], ebx
	mov ebx, [S]
	mov [SAIDA1+19*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+20*4], ebx
	mov ebx, [S]
	mov [SAIDA1+21*4], ebx
	mov ebx, [E]
	mov [SAIDA1+22*4], ebx
	mov ebx, [R]
	mov [SAIDA1+23*4], ebx
	mov ebx, [A]
	mov [SAIDA1+24*4], ebx
	mov ebx, [SPACE]
	mov [SAIDA1+25*4], ebx
	mov ebx, [FIM]
	mov [SAIDA1+26*4], ebx
	push DWORD SAIDA1
	call EscreverString
	add esp,4
	mov eax, [RESPOSTA2]
	add eax, [CINQUENTA]
	mov [RESPOSTA2], eax
	push DWORD [RESPOSTA2]
	call EscreverInteiro
	add esp,4
	push DWORD SPACE
	call EscreverChar
	add esp,4
	mov ebx, [A]
	mov [SAIDA1], ebx
	mov ebx, [N]
	mov [SAIDA1+1*4], ebx
	mov ebx, [O]
	mov [SAIDA1+2*4], ebx
	mov ebx, [S]
	mov [SAIDA1+3*4], ebx
	mov ebx, [ENDL]
	mov [SAIDA1+4*4], ebx
	mov ebx, [FIM]
	mov [SAIDA1+5*4], ebx
	push DWORD SAIDA1
	call EscreverString
	add esp,4
	mov eax,1
	mov ebx,0
	int 80h
section .data
	A dd 0X41
	B dd 0X42
	C dd 0X43
	D dd 0X44
	E dd 0X45
	F dd 0X46
	G dd 0X47
	H dd 0X48
	I dd 0X49
	J dd 0X4A
	K dd 0X4B
	L dd 0X4C
	M dd 0X4D
	N dd 0X4E
	O dd 0X4F
	P dd 0X50
	Q dd 0X51
	R dd 0X52
	S dd 0X53
	T dd 0X54
	U dd 0X55
	V dd 0X56
	W dd 0X57
	X dd 0X58
	Y dd 0X59
	Z dd 0X5A
	SPACE dd 0X20
	ENDL dd 0XA
	FIM dd 0
	CINCO dd 0X35
	ZERO dd 0X30
	SAIDA1 dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	SAIDA2 dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	RESPOSTA1 dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	RESPOSTA2 dd 0
	RESPOSTA3 dd 0
	CINQUENTA dd 50
	ERRO dd 444


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
