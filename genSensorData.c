#include<stdio.h>
#include<string.h>
#define BUFFERSIZE 1000

int main(int argc, char *argv[]){
	printf("welcome to mon fion\n");

	char buffer[BUFFERSIZE];
	while (fgets(buffer,BUFFERSIZE,stdin)){
	//printf("buffer=%s\n", buffer);
	if( strcmp(buffer,"OK\n")==0){

		printf("sensor; LastUpdate:21/04/2020; SensorId:52315x; SensorName: DoorSensor; Value:50; MaxValue:75;\n");
	}
	else if ( strcmp(buffer,"ERROR\n")==0) {

		printf("error;bad data!\n");
	}
	fflush(stdout);
	}

	return 0;

}
