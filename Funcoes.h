/*------------------------------------------------------------------------------------
	Trabalho 1 - Software Básico 01/2016 - Turma B

Nome: 	Letícia Helena Silva Porto 						11/0127846
		Rodrigo Werberich da Silva Moreira de Oliveira 	11/0139411

Nome do arquivo: Montador.h

Descricao: Esqueleto da classe Montador, que realiza o pre-processamento, primeira e segunda 
passagem do código de entrada e gera o arquivo de saída com o código final em formato .o
----------------------------------------------------------------------------------------*/

#ifndef SB_FUNCOES
#define SB_FUNCOES

#include <string>

namespace Montador{

	string funcoes ="\nsection .text"
	"\nLerInteiro:"
	"\n\tenter 5,0"
	"\n\tpush eax"
	"\n\tpush ebx"
	"\n\tpush ecx"
	"\n\tpush edx"
	"\n\tmov ebx,ebp"
	"\n\tsub ebx,1"
	"\n\tmov dword [EBP-5],0"
"\nlerI:"
	"\n\tpush ebx"
	"\n\tcall LerChar"
	"\n\tadd esp,4"
	"\n\tcmp byte [EBP-1],0xa"
	"\n\tje fim"
	"\n\tmov eax, [EBP-5]"
	"\n\tmov edx,eax"
	"\n\tshl eax,2"
	"\n\tadd eax,eax"
	"\n\tadd eax,edx"
	"\n\tadd eax,edx"
	"\n\tmov [EBP-5],eax"
	"\n\tmov eax,[EBP-1]"
	"\n\tsub eax,0x30"
	"\n\tadd [EBP-5],eax"
	"\n\tjmp lerI"
"\nfim:"
	"\n\tmov eax,[EBP-5]"
	"\n\tmov ebx,[EBP+8]"
	"\n\tmov [ebx],eax "
	"\n\tpop edx"
	"\n\tpop ecx"
	"\n\tpop ebx"
	"\n\tpop eax"
	"\n\tleave"
	"\n\tret"

	"\nEscreverInteiro:"
	"\n\tenter 0,0"
	"\n\tpush eax"
	"\n\tpush ecx"
	"\n\tpush edx"
	"\n\tmov eax,[EBP+8]"
	"\n\tmov edx,0"
	"\n\tpush edx"
	"\n\tmov ecx,10"
"\nwhile:"
	"\n\tmov edx,0"
	"\n\tdiv ecx"
	"\n\tadd edx,0x30"
	"\n\tpush edx"
	"\n\tcmp eax,0"
	"\n\tjnz while"
	"\n\tpush esp"
	"\n\tcall EscreverString"
	"\n\tadd esp,4"
	"\n\tpop edx"
	"\n\tpop ecx"
	"\n\tpop eax"
	"\n\tleave"
	"\n\tret"

	"\nLerString:"
	"\n\tenter 0,0"
	"\n\tpush ebx"
	"\n\tpush ecx"
	"\n\tmov eax,0"
"\nler:"
	"\n\tmov ecx,[EBP+8]"
	"\n\tmov ebx,eax"
	"\n\tshl ebx,2"
	"\n\tadd ecx,ebx"
	"\n\tpush ecx"
	"\n\tcall LerChar"
	"\n\tinc eax"
	"\n\tcmp dword [ecx],0xa"
	"\n\tjne ler"
	"\n\tadd esp,4"
	"\n\tmov dword [ecx],0"
	"\n\tpop ecx"
	"\n\tpop ebx"
	"\n\tleave"
	"\n\tret"

	"\nEscreverString:"
	"\n\tenter 0,0"
	"\n\tpush eax"
	"\n\tmov eax,[EBP+8]"
"\nescreve:"
	"\n\tpush eax"
	"\n\tcall EscreverChar"
	"\n\tadd esp,4"
	"\n\tadd eax,4"
	"\n\tcmp dword [eax],0"
	"\n\tjnz escreve"
	"\n\tpop eax"
	"\n\tleave"
	"\n\tret"

	"\nLerChar:"
	"\n\tenter 0,0"
	"\n\tpush eax"
	"\n\tpush ebx"
	"\n\tpush ecx"
	"\n\tpush ebx"
	"\n\tmov eax, 3"
	"\n\tmov ebx, 0"
	"\n\tmov ecx, [EBP+8] "
	"\n\tmov edx, 1"
	"\n\tint 80h"
	"\n\tpop edx"
	"\n\tpop ecx"
	"\n\tpop ebx"
	"\n\tpop eax"
	"\n\tleave"
	"\n\tret"

	"\nEscreverChar:"
	"\n\tenter 0,0"
	"\n\tpush eax"
	"\n\tpush ebx"
	"\n\tpush ecx"
	"\n\tpush ebx"
	"\n\tmov eax,4"
	"\n\tmov ebx,1"
	"\n\tmov ecx,[EBP+8]"
	"\n\tmov edx,1"
	"\n\tint 80h"
	"\n\tpop edx"
	"\n\tpop ecx"
	"\n\tpop ebx"
	"\n\tpop eax"
	"\n\tleave"
	"\n\tret"; 

}

#endif