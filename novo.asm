section text
s_input A
store b
output b
input H
load H
sub H
store B
output B
store B
output B
input B
store B
output B
jmpz zero
volta: add U
store B
output B
output B
output B
s_output A
jmpp um
v2: sub G
store B
output B
s_output A
jmpn dois
zero: output Z
jmp volta
jmp exit
um: output U
jmp v2
jmp exit
dois: output D

exit: stop
section data
H: space 4
B: space
A: space 20
G: const 5
Z: const 0
U: const 1
D: const 2

