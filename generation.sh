#!/bin/bash

timer=$1
Dir=$2
fileName1=$3
fileName2=$4

#./genTick $timer | ./genSensorData 1> $fileName1.txt 
#./genTick $timer | ./genSensorData  
./genTick $timer | ./genSensorData 2>&1 | {
    while IFS= read -r RAW_LINE; do
    echo $RAW_LINE
    echo $RAW_LINE >> monfichier.log
    done
}

