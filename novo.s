section .data
H dd 0,0,0
B dd 0
G dd 0X002
section .text
global _start
_start:
add eax, [H+1]
mov ebx, [B]
mov [G+1], ebx
mov eax,1
mov ebx,0
int 80h

