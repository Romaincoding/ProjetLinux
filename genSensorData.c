#include<stdio.h>
#include<string.h>
#define BUFFERSIZE 1000

int main(int argc, char *argv[]){
	printf("welcome to mon fion\n");

	char buffer[BUFFERSIZE];
	while (fgets(buffer,BUFFERSIZE,stdin)){
	//printf("buffer=%s\n", buffer);
	if( strcmp(buffer,"OK\n")==0){

		printf("toutes les portes sont bien fermées");
	}
	else if ( strcmp(buffer,"ERROR\n")==0) {

		printf("Attention la porte de l'entrée est ouverte!");
	}
	}

	return 0;

}
