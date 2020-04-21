#include<stdio.h>
#define BUFFERSIZE 1000

int main(int argc, char *argv[]){
	printf("welcome to mon fion\n");

	char buffer[BUFFERSIZE];

	while (	fgets(buffer,BUFFERSIZE,stdin))
	{
		printf("%s", buffer);
	}

	return 0;

}
