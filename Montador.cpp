/*------------------------------------------------------------------------------------
	Trabalho 1 - Software Básico 01/2016 - Turma B

Nome: 	Letícia Helena Silva Porto 						11/0127846
		Rodrigo Werberich da Silva Moreira de Oliveira 	11/0139411

Nome do arquivo: Montador.cpp

Descricao: Este arquivo contém a definicao dos métodos da classe Montador, que realiza as 
etapas de pre-processamento, primeira passagem, segunda passagem e geracao do arquivo de saida.
----------------------------------------------------------------------------------------*/

#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <stdlib.h>

#include "Token.h"
#include "Montador.h"
#include "Linha.h"
#include "Tabelas_montador.h"
#include "Tabelas.h"
#include "Buffer.h"
#include "SeparadorDeLinhas.h"

using namespace std;

namespace Montador{

	/* Construtor da classe Montador
	Inicializa os atributos da classe Montador.
	Parâmetros: arquivo de entrada e arquivo de saída.
	*/
	Montador::Montador(std::string arquivo_dado){
		arquivo = arquivo_dado;
		saida = arquivo.substr(0,arquivo.size()-3)+"s";
		section_text = false;
		section_data = false;
		ignorar_linha = false;
		existe_stop = false;
		linha_processada = false;
		rotulo_sozinho = false;
		endereco_uso = 0;
	}

	/* Método da classe Montador
	Realiza o pre-processamento do programa em Assembly inventado.
	Analisa linha a linha, com o auxílio da classe Linha.
	Separa os Tokens de cada linha, utilizando o método separar_linhas da classe SeparadorDeLinhas
	e armazena-os em um objeto da classe Token.
	Faz o tratamento de EQU.
	*/
	void Montador::pre_processamento() 
	{ 
		Buffer b(arquivo);
		SeparadorDeLinhas sep;
		unsigned int num_linha = 1;
		while(!b.fim()){
			std::string linha = b.proxima_linha();
			try{
				std::vector<Token> tokens = sep.separar_linha(linha);
				if(!tokens.empty()){
					Linha linha_separada = Linha(tokens,num_linha);
					tratar_EQU(linha_separada);
					linhas.push_back(linha_separada);
				}
			}catch(const std::invalid_argument& ia){
				gerar_erro(ia,num_linha);
			}
			num_linha++;
		}
	}
	
	/* Método da classe Montador
	Realiza a primeira passagem do Montador.
	Identifica os rótulos, diretivas e instrucoes do código de entrada através de outros métodos
	da classe Montador (identificar_rotulo, identificar_diretiva e identificar_instrucao).
	Verifica se as secoes do código de entrada foram declaradas corretamente.
	E verifica se as declaracoes das diretivas e das instrucoes possuem o numero de argumentos corretos
	e estao na secao correta.
	*/
	void Montador::primeira_passagem(){
		int endereco = 0;
		string rotulo;
		std::vector<vector<Linha>::iterator> linhas_removidas;
		for(vector<Linha>::iterator linha = linhas.begin(); linha!=linhas.end(); ++linha) {
			vector<Token> tokens_linha = linha->get_tokens();
			corretor_posicao = 0;
			linha_processada = false;
			if(!ignorar_linha){
				try {
					rotulo = identificar_rotulo(tokens_linha);
					
					if(!rotulo.empty())
						linha->remover_rotulo();

					if(!rotulo.empty() && tokens_linha.size()<2){
						rotulo_sozinho = true;
						rotulo_anterior = rotulo;
					}
					else if(!rotulo.empty() && tokens_linha.size()<3){
						if(tokens_linha[1].get_str()==":"){
							rotulo_sozinho = true;
							rotulo_anterior = rotulo;
						}
					}
					else{
						if(rotulo.empty() && rotulo_sozinho)
							rotulo = rotulo_anterior;
						rotulo_sozinho = false;
					}
					if(!rotulo_sozinho){
						if(identificar_diretiva(tokens_linha))
							executar_diretiva(tokens_linha,rotulo,endereco,linha->get_numero());
						else if(identificar_instrucao(tokens_linha))
							executar_instrucao(tokens_linha,rotulo,endereco,linha->get_numero());
						else{
							linhas_removidas.push_back(linha);
						}
					}else
						linha_processada = true;
					if(linha_processada)
						linhas_removidas.push_back(linha);
				
				}catch(const std::invalid_argument& ia){
					linhas_removidas.push_back(linha);
					gerar_erro(ia,linha->get_numero());
				}
			}else{
				linhas_removidas.push_back(linha);
				ignorar_linha = false;
			}
		}
		while(!linhas_removidas.empty()){
			linhas.erase(linhas_removidas.back());
			linhas_removidas.pop_back();
		}
	}

	/* Método da classe Montador
	Realiza a segunda passagem do Montador.
	Identifica as diretivas e instrucoes do código de entrada através de outros métodos
	da classe Montador (identificar_diretiva e identificar_instrucao).
	Codifica o programa inicial com o auxilio dos métodos codificar_diretiva e codificar_instrucao.
	*/
	void Montador::segunda_passagem(){
		for(vector<Linha>::iterator linha = linhas.begin(); linha!=linhas.end(); ++linha) {
			vector<Token> tokens_linha = linha->get_tokens();
			corretor_posicao = -1;
			try {
				if(identificar_diretiva(tokens_linha)){
					codificar_diretiva(tokens_linha,linha->get_numero());
				}else if(identificar_instrucao(tokens_linha)){
					codificar_instrucao(tokens_linha,linha->get_numero());
				}
			}catch(const std::invalid_argument& ia){
				gerar_erro(ia,linha->get_numero());
			} 	
		}
	}

	/* Método da classe Montador
	Gera o arquivo de saida, caso nao encontre nenhum erro léxico, sintático ou semantico.
	Caso nao seja um módulo, copia o código gerado pro arquivo.
	Caso seja um modulo, gera as tabelas de uso e de definicao, atraves dos métodos gerar_tabela_uso e 
	gerar_tabela_definicao e escreve os enderecos relativos no arquivo final.
	*/
	void Montador::gerar_arquivo(){
		if(!erro){
			std::ofstream s_arquivo(string(saida).c_str());
			if (s_arquivo.is_open()){
				s_arquivo << codigo << endl;
			}
			s_arquivo.close();
		}
	}

	/* Método da classe Montador
	Retorna uma string com a tabela de uso para escrever no arquivo de saida.
	Gera tabela de uso pro arquivo final.
	Caso seja um módulo, gera a tabela de uso em uma string, que estava armazenada 
	em um objeto da classe Tabela_Uso.
	*/
	string Montador::gerar_tabela_uso(){
		string rotulo = " ",endereco,uso;
		int i = 0;
		while(!rotulo.empty()){
			rotulo = tabela_de_uso.get_simbolo_uso(i);
			endereco = tabela_de_uso.get_endereco_uso(i);
			uso += rotulo + " " + endereco+"\n";
			i++;
		}
		return uso;
	}

	/* Método da classe Montador
	Retorna uma string com a tabela de definicoes para escrever no arquivo de saida.
	Gera tabela de definicoes pro arquivo final.
	Caso seja um módulo, gera a tabela de definicoes em uma string, que estava armazenada 
	em um objeto da classe Tabela_Definicoes.
	*/
	string Montador::gerar_tabela_definicao(){
		string rotulo = " ",endereco,def;
		int i = 0;
		while(!rotulo.empty()){
			rotulo = tabela_definicao.get_simbolo_def(i);
			endereco = tabela_definicao.get_endereco_def(i);
			def += rotulo + " " + endereco+"\n";
			i++;
		}
		return def;
	}

	/* Método da classe Montador
	Recebe um objeto da classe Linha, que contem todas as linhas do arquivo.
	É chamada no pre-processamento para tratar as EQU.
	*/
	void Montador::tratar_EQU(Linha & linha){
		vector<Token> tokens_linha = linha.get_tokens();
		string rotulo, valor, s_token;
		bool equ = false;
		bool dois_pontos;
		corretor_posicao = 0;
		
		for(unsigned int i=0;i<tokens_linha.size();i++){
			dois_pontos = false;
			s_token = tokens_linha[i].get_str();
			valor = tabela_EQU.pegar_equ(s_token);
			if(valor.empty()){
				valor = tabela_EQU.pegar_equ(s_token.substr(0,s_token.size()-1));
				dois_pontos = true;
			}
			if(!valor.empty()){
				if(dois_pontos){
					linha.substituir_token(valor+string(":"),i);
				}else{
					linha.substituir_token(valor,i);
				}
			}
		}

		if(tokens_linha.size()>1){
			if(tokens_linha[1].get_str()=="EQU"){
				equ = true;
			}else if(tokens_linha.size()>2){
				if(tokens_linha[1].get_str()==":" && tokens_linha[2].get_str()=="EQU"){
					equ = true;
					corretor_posicao++;
				}
			}
		}
		if(equ){
			rotulo = tokens_linha[0].get_str().substr(0,tokens_linha[0].get_str().size()-1);
			if(tokens_linha.size() > (2+corretor_posicao)){
				valor = tokens_linha[2+corretor_posicao].get_str();
				tabela_EQU.inserir_equ(rotulo, valor);
			}
		}
	}

	/* Método da classe Montador
	Argumentos recebidos: O vetor de tokens de uma determinada linha
	Retorna: uma string que seria o rotulo da linha
	Identifica se o primeiro token da linha é um rótulo e caso seja, se é uma label válida.
	*/
	std::string Montador::identificar_rotulo(std::vector<Token> & tokens){
		string rotulo;
		if (tokens[0].verifica_rotulo()) {
			rotulo = tokens[0].get_str().substr(0,tokens[0].get_str().size()-1);
		}else if(tokens.size() > 1){
			if(tokens[1].get_str() == string(":")) {
				rotulo = tokens[0].get_str();
				corretor_posicao++;
			}else{
				corretor_posicao--;
			}
		}else{
			corretor_posicao--;
		}	
		
		return rotulo;
	}

	/* Método da classe Montador
	Argumento recebido: um vetor de objetos da classe tokens de uma determinada linha.
	Procura na tabela de diretivas se a linha contem um token que é uma diretiva válida e
	retorna um boleano que indica se a linha contem uma diretiva válida.
	*/
	bool Montador::identificar_diretiva(std::vector<Token> & tokens){
		string diretiva = tokens[1+corretor_posicao].get_str();
		if (tabela_diretiva.teste_diretiva(diretiva)){
			return true;
		}else{
			return false;
		}
	}

	/* Método da classe Montador
	Argumentos de entrada: o vetor de tokens de uma determinada linha, o rotulo dessa linha e o endereco.
	É um método utilizado na primeira passagem, que verifica se as diretivas utilizadas no programa 
	estao com o número correto de argumentos e se estao na secao correta.
	Verifica também se as diretivas que obrigatoriamente tem que ter uma label antes sao precedidas 
	por labels.
	Nesse método coloca-se as labels que indicam uma diretiva na tabela de símbolos.
	*/
	void Montador::executar_diretiva(std::vector<Token> & tokens,string rotulo, int & endereco, int num_linha){
		string diretiva = tokens[1+corretor_posicao].get_str();
		if (diretiva == "SECTION"){
			//linha_processada = true;
			if(!rotulo.empty()){
				tabela_simbolo.inserir_simbolo(rotulo,endereco,0,false,true,true,false,num_linha);
			}
			diretiva_section(tokens[2+corretor_posicao].get_str());
		}else if(diretiva == "CONST"){
			if(!rotulo.empty()){
				if(tokens.size()>2){
					int argumento = atoi(tokens[2+corretor_posicao].get_str().c_str());
					if(argumento == 0){
						tabela_simbolo.inserir_simbolo(rotulo,endereco,0,false,true,false,true,num_linha);
					}else{
						tabela_simbolo.inserir_simbolo(rotulo,endereco,0,false,true,false,false,num_linha);
					}
				}				
			}
		}else if(diretiva == "EQU"){
			linha_processada = true;
		}else if(diretiva == "IF"){
			linha_processada = true;
			string argumento = tokens[2+corretor_posicao].get_str();
			if(argumento == "0"){
				ignorar_linha = true;
			}
		}
		unsigned int num_op = tabela_diretiva.get_operandos(diretiva);
		if(diretiva == "SPACE"){
			if(0==tokens.size()-(2+corretor_posicao)){
				if(!rotulo.empty()){
			 		tabela_simbolo.inserir_simbolo(rotulo,endereco,0,false,false,false,false,num_linha);
			    }
			    endereco+=1;
			}else if(1==tokens.size()-(2+corretor_posicao)){
				string s_num = tokens[2+corretor_posicao].get_str();
				int num = atoi(s_num.c_str());
				if(!rotulo.empty()){
			 		tabela_simbolo.inserir_simbolo(rotulo,endereco,num,false,false,false,false,num_linha);
			    }
			    endereco += num;
			}
		}else{
			endereco += tabela_diretiva.get_tamanho(diretiva);
		}
	}

	/* Método da classe Montador
	Argumento de entrada: vetor de tokens de uma determinada linha.
	Procura na tabela de instrucoes se a linha contem um token que é uma instrucao válida e
	retorna um boleano que indica se a linha contem uma instrucao válida.
	*/
	bool Montador::identificar_instrucao(std::vector<Token> & tokens){
		string instrucao = tokens[1+corretor_posicao].get_str();
		if (tabela_instrucao.teste_instrucao(instrucao)){
			return true;
		}else{
			return false;
		}
	}

	/* Método da classe Montador
	Argumentos de entrada: o vetor de tokens de uma determinada linha, o rotulo dessa linha e o endereco.
	É um método utilizado na primeira passagem, que verifica se as instrucoes utilizadas no programa 
	estao com o número correto de argumentos e se estao na secao correta.
	Nesse método coloca-se as labels que precedem uma instrucao na tabela de símbolos.
	*/
	void Montador::executar_instrucao(std::vector<Token> & tokens,string rotulo, int & endereco, int num_linha){
		string instrucao = tokens[1+corretor_posicao].get_str();
		if(!rotulo.empty()){
				tabela_simbolo.inserir_simbolo(rotulo,endereco,0,false,true,true,false,num_linha);
		}

		if(instrucao == "STOP")
			existe_stop = true;

		unsigned int num_op = tabela_instrucao.get_operandos(instrucao);
		endereco += tabela_instrucao.get_tamanho(instrucao);
	}

	/* Método da classe Montador
	Argumentos de entrada: o número da linha que vai gerar o erro, o argumento que gera a execao
	Esse método captura as execoes geradas durante a execucao da classe Montador e exibe no terminal
	os erros indicando em qual linha do programa jele aconteceu.
	*/
	void Montador::gerar_erro(const std::invalid_argument& ia,int num_linha){
		stringstream ss;
		ss << num_linha;
		string s_num_linha = ss.str();
		erro = true;		
		std::cout << std::string(" Linha ")+s_num_linha+std::string(": ")+ia.what() << std::endl;
	}

	/* Método da classe Montador
	Argumentos de entrada: string que indica qual o tipo de section ser tratada.
	É utilizada no método "executar_diretiva" e verifica se as secoes TEXT e DATA estao na ordem correta
	no programa de entrada.
	Verifica tambem se a secao definida é uma secao válida.	
	*/	
	void Montador::diretiva_section(string argumento){
		if (argumento == "TEXT"){
			section_text = true;

		}else if(argumento == "DATA"){
			section_data = true;

		}
	}

	/* Método da classe Montador
	Argumentos de entrada: o vetor de tokens de uma determinada linha.
	É um método utilizado na segunda passagem. 
	Cria a tabela de definicao, para os argumentos declarados como PUBLIC.
	Codifica a diretiva SPACE, calculando o espaco de memória reservado para cada label e escreve
	o codigo correspondente na string "codigo".
	Codifica a diretiva CONST, verificando se o argumento dela é um numero ou nao é válido e escreve
	o código na string "codigo".
	*/
	void Montador::codificar_diretiva(std::vector<Token> tokens, int num_linha){
		
		string argumento, diretiva = tokens[0].get_str(); 
		int endereco;

		if(diretiva == "SECTION"){
			if (tokens.size()>1) {
				argumento = tokens[1].get_str();
				if (argumento == "DATA"){
					codigo += "section .data\n";
				}else if(argumento == "TEXT"){
					codigo += "section .text\nglobal _start\n_start:\n";
				}
			} 
		}

		if(diretiva == "SPACE") {
			if (tokens.size()>1) {
				argumento = tokens[1].get_str();
				codigo += tabela_simbolo.get_rotulo(num_linha)+" dd ";
				for (int i = 0;i<atoi(argumento.c_str())-1;i++){
					codigo += "0,";
				}
				codigo+="0\n";
			}else 
				codigo += tabela_simbolo.get_rotulo(num_linha)+" dd 0\n";
		}
		else if(diretiva == "CONST") {
			argumento = tokens[1].get_str();
				codigo += tabela_simbolo.get_rotulo(num_linha)+" dd "+argumento+"\n";
		}
	}

	/* Método da classe Montador
	Argumentos de entrada: o vetor de tokens de uma determinada linha.
	É um método utilizado na segunda passagem. 
	Codifica todas as instrucoes estabelecidas para o Assembly inventado, analisando se a estrutura
	da linha que contem a instrucao é sintaticamente e semanticamente válida, ou seja, confere se os
	argumentos dados sao válidos sintaticamente e semanticamente.
	Escreve o código gerado de cada instrucao na string "codigo".
	*/
	void Montador::codificar_instrucao(std::vector<Token> tokens, int num_linha){

		string argumento, argumento2, instrucao = tokens[0].get_str(); 
		
		if (!tabela_simbolo.get_rotulo(num_linha).empty()){
			codigo += tabela_simbolo.get_rotulo(num_linha)+": ";
		}
		if (instrucao == "ADD"){
			if (tokens.size()>2){
				argumento = tokens[1].get_str();
				argumento2= tokens[3].get_str();

				codigo += "add eax, ["+argumento+"+"+argumento2+"*4]\n";
			}else {
				argumento = tokens[1].get_str();
				codigo += "add eax, ["+argumento+"]\n";
			}
		}
		else if (instrucao == "SUB"){
			if (tokens.size()>2){
				argumento = tokens[1].get_str();
				argumento2= tokens[3].get_str();

				codigo += "sub eax, ["+argumento+"+"+argumento2+"*4]\n";
			}else {
				argumento = tokens[1].get_str();
				codigo += "sub eax, ["+argumento+"]\n";
			}
		}
		else if (instrucao == "MULT"){
			if (tokens.size()>2){
				argumento = tokens[1].get_str();
				argumento2= tokens[3].get_str();

				codigo += "mul DWORD ["+argumento+"+"+argumento2+"*4]\n";
			}else {			
				argumento = tokens[1].get_str();
				codigo += "mul DWORD ["+argumento+"]\n";
			}
		}
		else if (instrucao == "DIV"){
			if (tokens.size()>2){
				argumento = tokens[1].get_str();
				argumento2= tokens[3].get_str();

				codigo += "div DWORD ["+argumento+"+"+argumento2+"*4]\n";
			}else {
				argumento = tokens[1].get_str();
				codigo += "div DWORD ["+argumento+"]\n";
			}
		}
		else if (instrucao == "JMP"){
			if (tokens.size()>2){
				argumento = tokens[1].get_str();
				argumento2= tokens[3].get_str();

				codigo += "jmp "+argumento+"+"+argumento2+"*4\n";
			}else {
				argumento = tokens[1].get_str();
				codigo += "jmp "+argumento+"\n";
			}
		}
		else if (instrucao == "JMPN"){
			if (tokens.size()>2){
				argumento = tokens[1].get_str();
				argumento2= tokens[3].get_str();

				codigo += "cmp eax, 0\n";
				codigo += "jb "+argumento+"+"+argumento2+"*4\n";
			}else {
				argumento = tokens[1].get_str();
				codigo += "cmp eax, 0\n";
				codigo += "jb "+argumento+"\n";
			}
		}
		else if (instrucao == "JMPP"){
			if (tokens.size()>2){
				argumento = tokens[1].get_str();
				argumento2= tokens[3].get_str();

				codigo += "cmp eax, 0\n";
				codigo += "ja "+argumento+"+"+argumento2+"*4\n";
			}else {
				argumento = tokens[1].get_str();
				codigo += "cmp eax, 0\n";
				codigo += "ja "+argumento+"\n";
			}
		}
		else if (instrucao == "JMPZ"){
			if (tokens.size()>2){
				argumento = tokens[1].get_str();
				argumento2= tokens[3].get_str();

				codigo += "cmp eax, 0\n";
				codigo += "je "+argumento+"+"+argumento2+"*4\n";
			}else {
				argumento = tokens[1].get_str();
				codigo += "cmp eax, 0\n";
				codigo += "je "+argumento+"\n";
			}
		}
		else if (instrucao == "COPY"){
			if (tokens.size()>3){

				if(tokens[2].get_str() == "+" && tokens.size()<6) {

					argumento = tokens[1].get_str()+"+"+tokens[3].get_str();
					argumento = argumento.substr(0,argumento.size()-1);
					argumento2= tokens[4].get_str();

					codigo += "mov ebx, ["+argumento+"]\n";
					codigo += "mov ["+argumento2+"], ebx\n";
				}else if (tokens[2].get_str() != "+" && tokens[3].get_str() == "+"){

					argumento = tokens[1].get_str();
					argumento = argumento.substr(0,argumento.size()-1);
					argumento2= tokens[2].get_str()+"+"+tokens[4].get_str();

					codigo += "mov ebx, ["+argumento+"]\n";
					codigo += "mov ["+argumento2+"], ebx\n";

				}else if (tokens.size()> 6) {
					if (tokens[2].get_str() == "+" && tokens[5].get_str() == "+"){

						argumento = tokens[1].get_str()+"+"+tokens[3].get_str();
						argumento = argumento.substr(0,argumento.size()-1);
						argumento2= tokens[4].get_str()+"+"+tokens[6].get_str();

						codigo += "mov ebx, ["+argumento+"]\n";
						codigo += "mov ["+argumento2+"], ebx\n";
					}
				}
				

			}else {
				argumento = tokens[1].get_str();
				argumento = argumento.substr(0,argumento.size()-1);
				argumento2 = tokens[2].get_str();
				codigo += "mov ebx, ["+argumento+"]\n";
				codigo += "mov ["+argumento2+"], ebx\n";
			}
		}
		else if (instrucao == "LOAD"){
			if (tokens.size()>2){
				argumento = tokens[1].get_str();
				argumento2= tokens[3].get_str();

				codigo += "mov eax, ["+argumento+"+"+argumento2+"*4]\n";
			}else {
				argumento = tokens[1].get_str();
				codigo += "mov eax, ["+argumento+"]\n";
			}
		}
		else if (instrucao == "STORE"){
			if (tokens.size()>2){
				argumento = tokens[1].get_str();
				argumento2= tokens[3].get_str();

				codigo += "mov ["+argumento+"+"+argumento2+"*4], eax\n";
			}else {
				argumento = tokens[1].get_str();
				codigo += "mov ["+argumento+"], eax\n";
			}
		}
		// else if (instrucao == "INPUT"){
		// 	argumento = tokens[1].get_str();
		// 	codigo += "mov ["+argumento+"], eax\n";
		// }
		// else if (instrucao == "OUTPUT"){
		// 	argumento = tokens[1].get_str();
		// 	codigo += "mov ["+argumento+"], eax\n";
		// }
		// else if (instrucao == "C_INPUT"){
		// 	argumento = tokens[1].get_str();
		// 	codigo += "mov ["+argumento+"], eax\n";
		// }
		// else if (instrucao == "C_OUTPUT"){
		// 	argumento = tokens[1].get_str();
		// 	codigo += "mov ["+argumento+"], eax\n";
		// }
		// else if (instrucao == "S_INPUT"){
		// 	argumento = tokens[1].get_str();
		// 	codigo += "mov ["+argumento+"], eax\n";
		// }
		// else if (instrucao == "S_OUTPUT"){
		// 	argumento = tokens[1].get_str();
		// 	codigo += "mov ["+argumento+"], eax\n";
		// }
		else if (instrucao == "STOP"){
			codigo += "mov eax,1\nmov ebx,0\nint 80h\n";
		}
		
	}
}