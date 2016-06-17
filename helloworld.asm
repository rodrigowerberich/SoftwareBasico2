section text

COPY D, saida1
COPY I, saida1 + 1
COPY G, saida1 + 2
COPY I, saida1 + 3
COPY T, saida1 + 4
COPY E, saida1 + 5
COPY space, saida1 + 6
COPY S, saida1 + 7
COPY E, saida1 + 8
COPY U, saida1 + 9
COPY space, saida1 + 10
COPY N, saida1 + 11
COPY O, saida1 + 12
COPY M, saida1 + 13
COPY E, saida1 + 14
COPY endl, saida1 + 15
COPY fim, saida1 + 16

S_OUTPUT saida1

S_INPUT resposta1

COPY D, saida1
COPY I, saida1 + 1
COPY G, saida1 + 2
COPY I, saida1 + 3
COPY T, saida1 + 4
COPY E, saida1 + 5
COPY space, saida1 + 6
COPY S, saida1 + 7
COPY U, saida1 + 8
COPY A, saida1 + 9
COPY space, saida1 + 10
COPY I, saida1 + 11
COPY D, saida1 + 12
COPY A, saida1 + 13
COPY D, saida1 + 14
COPY E, saida1 + 15
COPY endl, saida1 + 16
COPY fim, saida1 + 17

S_OUTPUT saida1

INPUT resposta2

COPY D, saida1
COPY I, saida1 + 1
COPY G, saida1 + 2
COPY I, saida1 + 3
COPY T, saida1 + 4
COPY E, saida1 + 5
COPY space, saida1 + 6
COPY S, saida1 + 7
COPY U, saida1 + 8
COPY A, saida1 + 9
COPY space, saida1 + 10
COPY L, saida1 + 11
COPY E, saida1 + 12
COPY T, saida1 + 13
COPY R, saida1 + 14
COPY A, saida1 + 15
COPY space, saida1 + 16
COPY F, saida1 + 17
COPY A, saida1 + 18
COPY V, saida1 + 19
COPY O, saida1 + 20
COPY R, saida1 + 21
COPY I, saida1 + 22
COPY T, saida1 + 23
COPY A, saida1 + 24
COPY endl, saida1 + 25
COPY fim, saida1 + 26

S_OUTPUT saida1

INPUT resposta3


S_OUTPUT resposta1

C_OUTPUT space


COPY S, saida1
COPY U, saida1 + 1
COPY A, saida1 + 2
COPY space, saida1 + 3
COPY I, saida1 + 4
COPY D, saida1 + 5
COPY A, saida1 + 6
COPY D, saida1 + 7
COPY E, saida1 + 8
COPY space, saida1 + 9
COPY E, saida1 + 10
COPY M, saida1 + 11
COPY space, saida1 + 12
COPY CINCO, saida1 + 13
COPY ZERO, saida1 + 14
COPY space, saida1 + 15
COPY A, saida1 + 16
COPY N, saida1 + 17
COPY O, saida1 + 18
COPY S, saida1 + 19
COPY space, saida1 + 20
COPY S, saida1 + 21
COPY E, saida1 + 22
COPY R, saida1 + 23
COPY A, saida1 + 24
COPY space, saida1 + 25
COPY fim, saida1 + 26

S_OUTPUT saida1

LOAD resposta2
ADD CINQUENTA
STORE resposta2

OUTPUT resposta2

C_OUTPUT space

COPY A, saida1
COPY N, saida1 + 1
COPY O, saida1 + 2
COPY S, saida1 + 3
COPY endl, saida1 + 4
COPY fim, saida1 + 5

S_OUTPUT saida1



STOP

section data

A: CONST 0x41
B: CONST 0x42
C: CONST 0x43
D: CONST 0x44
E: CONST 0x45
F: CONST 0x46
G: CONST 0x47
H: CONST 0x48
I: CONST 0x49
J: CONST 0x4A
K: CONST 0x4B
L: CONST 0x4C
M: CONST 0x4D
N: CONST 0x4E
O: CONST 0x4F
P: CONST 0x50
Q: CONST 0x51
R: CONST 0x52
S: CONST 0x53
T: CONST 0x54
U: CONST 0x55
V: CONST 0x56
W: CONST 0x57
X: CONST 0x58
Y: CONST 0x59
Z: CONST 0x5A
space: CONST 0x20
endl: CONST 0xA
fim: CONST 0

CINCO: CONST 0x35
ZERO: CONST 0x30

saida1: SPACE 50
saida2: SPACE 50
resposta1: SPACE 50
resposta2: SPACE
resposta3: SPACE

CINQUENTA: CONST 50
ERRO: CONST 444