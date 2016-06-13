section text
calcloop: input mode	; 0 - exit % 1 - (+) % 2 - (-) % 3 - (*) % 4 - (/) % 5 - (%) % 6 - sgn(a) % 7 - Invalid
	input a
	input b
	load mode
	jmpz exitcalc
	load mode
	sub one
	jmpz addexec
	load mode
	sub two
	jmpz subexec
	load mode
	sub three
	jmpz mulexec
	load mode
	sub four
	jmpz divexec
	load mode
	sub five
	jmpz remexec
	load mode
	sub six
	jmpz sgnaexec
	jmp calcloop
addexec: load a
	add b
	store c
	jmp show
subexec: load a
	sub b
	store c
	jmp show
mulexec: load a
	mult b
	store c
	jmp show
divexec: load a
	div b
	store c
	jmp show
remexec: load a
	div b
	mult b
	store c
	load a
	sub c
	store c
	jmp show
sgnaexec: load a
	jmpn negative
	load zero
	jmp stsgn
negative: load one
stsgn: store c

show: output c
	jmp calcloop
exitcalc: stop

section data
a:	space
b:	space
c:	space
mode:	space
zero:	const 0
one:	const 1
two:	const 2
three:	const 3
four:	const 4
five:	const 5
six:	const 6
