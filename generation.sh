#!/bin/bash
#set -x

timer=$1
Dir=$2
fileName1=$3
fileName2=$4

echo $UID
mkdir /home/$USER/$Dir
#./genTick $timer | ./genSensorData 1> $fileName1.txt 
#./genTick $timer | ./genSensorData  
./genTick $timer | ./genSensorData 2>&1 | {
    while IFS= read -r RAW_LINE; do
    echo $RAW_LINE

     result=$(echo $RAW_LINE | cut -d "#" -f1 );
     filter=$(echo $RAW_LINE | cut -d ";" -f1,2,3,5);
    if [[ $result == "Sensor" ]]; then
        
        
       
        echo $filter >> /home/$USER/$Dir/$fileName1.log;
            
     else 

        echo $RAW_LINE >> /home/$USER/$Dir/$fileName2.log;

     
     fi
     


    #
    
    
   #     if ["$result" -eq "error"];then
    #        echo "ça marche"
     #   fi
    
    done
    
}


