#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>


#define CHAR_LF         '\n'
#define CHAR_CR         '\r'
#define STR_OK          "OK"
#define STR_ERR         "ERROR"
#define INPUT_SIZE       16
#define SENSOR_DATA_SIZE 128
#define NB_SENSORS       100

// boolean to exit from SIGINT
static volatile int isSigIntReceived = 0;


void sigIntHandler(int signo) {
    // check the number of the signal is the one expected
    if(signo == SIGINT){ 
        printf("The SIGINT signal has been received. \n");
        isSigIntReceived = 1;
    }
}

void printSensor(int isError){
    // Prepare sensor data
    char sensorData[SENSOR_DATA_SIZE];
    char name[16];
    int  sensorNum;
    int  min;
    int  max;
    int  mean;
    int  code;
    int value;
    
    // Random data
    sensorNum = rand()%NB_SENSORS;
    min   = rand()%1000;
    max   = rand()%20000+1000;
    mean  = (min+max)/2;
    code  = rand()%1000000000;
    value = rand()%(max-min)+min;    
    strcpy(name, "Cuisine");
    
    // display either error or correct data
    if(isError){
        // Prepare sensor string
        snprintf(sensorData, SENSOR_DATA_SIZE, "Error#%d;%s;code=0x%X;Message d'erreur ici\n", sensorNum, name, code);
        // send data to stderr
        //printf( "%s", sensorData );
        write( 2, &sensorData, strlen(sensorData) );
    }
    else{
        // Prepare sensor string
        snprintf(sensorData, SENSOR_DATA_SIZE, "Sensor#%d;%s;value=%d;minvalue=%d;maxvalue=%d;meanvalue=%d\n", sensorNum, name, value, min, max, mean);
        // send data to stdout
        // printf( "%s\n", sensorData );
        write( 1, &sensorData, strlen(sensorData) );
    }
}

void resetStr(char* pStr){
    *pStr = 0;
}

int main( int argc, char* argv[] )
{
    // local buffer to get input
    char input[INPUT_SIZE];
    int  index = 0;
    char car;

    
    // Add callback for signal SIGINT
    printf("Start genSensor \n");
    if( signal(SIGINT, sigIntHandler) == SIG_ERR ){
        printf("Impossible to catch SIGINT !!! \n");
    }
    fflush(stdout);
    
    // Reset input buffer
    index = 0;
    resetStr(input);
    
    // Loop until there is nothing else to read from standard input
    while( (read(0,&car,1) ==  1) && (isSigIntReceived == 0) ){

        // check if we have received a new line
        if(car == CHAR_LF || car == CHAR_CR){
            // compare the string
            if( strcmp(input, STR_OK) == 0 ){
                printSensor(0);
            }
            else if( strcmp(input, STR_ERR) == 0 ){
                printSensor(1);                
            }
            // Reset input buffer
            index = 0;
            resetStr(input);
        }
        else{
            // Store this character
            input[index] = car;
            // increase index for storage
            index = index+1;
            // Clear buffer if too long, else clear next char
            if(index >= INPUT_SIZE){

                // Reset input buffer
                index = 0;
                resetStr(input);
            }
            else{
                input[index] = 0;
            }
        }
        
        // Flush standard output
        fflush(stdout);
    }

    // end message
    printf("\n\nGOOD BYE geeks !\n\n");
    
    // Enf of program
    return 0;
}
