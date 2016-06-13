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

