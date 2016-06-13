section .data
H dd 0,0,0
B dd 0
G dd 2
section .text
global _start
_start:
mov eax,1
mov ebx,0
int 80h

