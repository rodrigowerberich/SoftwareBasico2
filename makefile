OBJS = Buffer.o Linha.o Montador.o Tabelas.o Tabelas_montador.o Token.o SeparadorDeLinhas.o tradutor.o
CC = g++
DEBUG = -g
CFLAGS =  -c $(DEBUG)
LFLAGS =  $(DEBUG)

tradutor : $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o tradutor

Buffer.o : Buffer.h Buffer.cpp
	$(CC) $(CFLAGS) Buffer.cpp

Linha.o : Linha.h Linha.cpp Buffer.h Token.h SeparadorDeLinhas.h 
	$(CC) $(CFLAGS) Linha.cpp

Montador.o : Montador.h Montador.cpp Buffer.h SeparadorDeLinhas.h Token.h Montador.h Linha.h Tabelas_montador.h Tabelas.h
	$(CC) $(CFLAGS) Montador.cpp

Tabelas.o : Tabelas_montador.h Tabelas.cpp Tabelas.h
	$(CC) $(CFLAGS) Tabelas.cpp

Tabelas_montador.o : Tabelas_montador.h Tabelas_montador.cpp
	$(CC) $(CFLAGS) Tabelas_montador.cpp

Token.o : Token.h Token.cpp
	$(CC) $(CFLAGS) Token.cpp

SeparadorDeLinhas.o: SeparadorDeLinhas.h SeparadorDeLinhas.cpp Token.h
	$(CC) $(CFLAGS) SeparadorDeLinhas.cpp

tradutor.o : tradutor.c Montador.h Funcoes.h
	$(CC) $(CFLAGS) tradutor.c

clean:
	\rm *.o

clean_all:
	\rm *.o tradutor	