section .text
global _start
_start:
mov eax, [B]
mul DWORD [H]
div DWORD [DOIS]
S: mov [R], eax
mov ebx, [B]
mov [H], ebx
add eax, [H]
mov eax,1
mov ebx,0
int 80h
section .data
B dd 0,0
H dd 0
R dd 0
DOIS dd 0X2

section .text
LerInteiro:enter 5,0push eaxpush ebxpush ecxpush edxmov ebx,ebpsub ebx,1mov dword [EBP-5],0lerI:push ebxcall LerCharadd esp,4cmp byte [EBP-1],0xaje fimmov eax, [EBP-5]mov edx,eaxshl eax,2add eax,eaxadd eax,edxadd eax,edxmov [EBP-5],eaxmov eax,[EBP-1]sub eax,0x30add [EBP-5],eaxjmp lerIfim:mov eax,[EBP-5]mov ebx,[EBP+8]mov [ebx],eax pop edxpop ecxpop ebxpop eaxleaveretEscreverInteiro:enter 0,0push eaxpush ecxpush edxmov eax,[EBP+8]push edxmov ecx,10while:mov edx,0div ecxadd edx,0x30push edxcmp eax,0jnz whilepush espcall EscreverStringadd esp,4pop edxpop ecxpop eaxleaveretLerString:enter 0,0push ebxpush ecxmov eax,0ler:mov ecx,[EBP+8]mov ebx,eaxshl ebx,2add ecx,ebxpush ecxcall LerCharinc eaxcmp dword [ecx],0xajne leradd esp,4mov dword [ecx],0pop ecxpop ebxleaveretEscreverString:enter 0,0push eaxmov eax,[EBP+8]escreve:push eaxcall EscreverCharadd esp,4add eax,4cmp dword [eax],0jnz escrevepop eaxleaveretLerChar:enter 0,0push eaxpush ebxpush ecxpush ebxmov eax, 3mov ebx, 0mov ecx, [EBP+8] mov edx, 1int 80hpop edxpop ecxpop ebxpop eaxleaveretEscreverChar:enter 0,0push eaxpush ebxpush ecxpush ebxmov eax,4mov ebx,1mov ecx,[EBP+8]mov edx,1int 80hpop edxpop ecxpop ebxpop eaxleaveret
