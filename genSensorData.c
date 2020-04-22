#include<stdio.h>
#include<string.h>
#define BUFFERSIZE 1000

int main(int argc, char *argv[]){
	printf("welcome to mon fion\n");

	char buffer[BUFFERSIZE];
	while (fgets(buffer,BUFFERSIZE,stdin)){
	//printf("buffer=%s\n", buffer);
	if( strcmp(buffer,"OK\n")==0){

		printf("sensor;100;0;50\n");
	}
	else if ( strcmp(buffer,"ERROR\n")==0) {

		printf("error;bad data!\n");
	}
	fflush(stdout);
	}

	return 0;

}
