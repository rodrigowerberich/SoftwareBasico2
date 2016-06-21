/*------------------------------------------------------------------------------------
	Trabalho 2 - Software Básico 01/2016 - Turma B

Nome: 	Letícia Helena Silva Porto 						11/0127846
		Rodrigo Werberich da Silva Moreira de Oliveira 	11/0139411

Nome do arquivo: traduto.c

Descricao: Este arquivo contém o código principal do Montador, ele cria um objeto da classe
Montador, passa os arquivos de entrada e de saida para o construtor e chama os métodos pre_processamento,
primeira_passagem, segunda_passagem e gerar_arquivo.
----------------------------------------------------------------------------------------*/
#include <iostream>
#include <stdexcept>
#include <string>
#include <cstdlib>

using namespace std;
int main(int argc, char const *argv[])
{
	// Verifica se foi dado o número correto de argumentos
	if(argc != 2){
		throw invalid_argument("Número de argumentos invalidos");
	}

	string file = argv[1];

	string nasm = "nasm -f elf " +  file +  " -o "+file.substr(0,file.size()-2)+".o";

	string ld = "ld -m elf_i386 -o " + file.substr(0,file.size()-2)+" "+file.substr(0,file.size()-2)+".o";

	// Cria o objeto montador
	system(nasm.c_str());
	system(ld.c_str());

    return 0;
}