section .text
global _start
_start:
CALCLOOP: mov eax, [MODE]
cmp eax, 0
je EXITCALC
mov eax, [MODE]
sub eax, [ONE]
cmp eax, 0
je ADDEXEC
mov eax, [MODE]
sub eax, [TWO]
cmp eax, 0
je SUBEXEC
mov eax, [MODE]
sub eax, [THREE]
cmp eax, 0
je MULEXEC
mov eax, [MODE]
sub eax, [FOUR]
cmp eax, 0
je DIVEXEC
mov eax, [MODE]
sub eax, [FIVE]
cmp eax, 0
je REMEXEC
mov eax, [MODE]
sub eax, [SIX]
cmp eax, 0
je SGNAEXEC
jmp CALCLOOP
ADDEXEC: mov eax, [A]
add eax, [B]
mov [C], eax
jmp SHOW
SUBEXEC: mov eax, [A]
sub eax, [B]
mov [C], eax
jmp SHOW
MULEXEC: mov eax, [A]
mul DWORD [B]
mov [C], eax
jmp SHOW
DIVEXEC: mov eax, [A]
div DWORD [B]
mov [C], eax
jmp SHOW
REMEXEC: mov eax, [A]
div DWORD [B]
mul DWORD [B]
mov [C], eax
mov eax, [A]
sub eax, [C]
mov [C], eax
jmp SHOW
SGNAEXEC: mov eax, [A]
cmp eax, 0
jb NEGATIVE
mov eax, [ZERO]
jmp STSGN
NEGATIVE: mov eax, [ONE]
STSGN: mov [C], eax
SHOW: jmp CALCLOOP
EXITCALC: mov eax,1
mov ebx,0
int 80h
section .data
A dd 0
B dd 0
C dd 0
MODE dd 0
ZERO dd 0
ONE dd 1
TWO dd 2
THREE dd 3
FOUR dd 4
FIVE dd 5
SIX dd 6

