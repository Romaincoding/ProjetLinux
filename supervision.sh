#!/bin/bash
set -x

timer=$1
Dir=$2
fileName1=$3
fileName2=$4
fileSize=$5

generationPID=0

# 1) declarer un generationPID=0
while true;do
#verifier que generation.sh n'existe pas=> si generatiopnPID=0, il faut le lancer 
        if [[ $generationPID -eq 0 ]];then 
                ./generation.sh $1 $2 $3 $4 &
                generationPID=$!          
#regarder si le sfichiers de logs pas trop gros => methode : du ou autre ou stat
                if [[du -h /home/$USER/$Dir/$3] -gt 1 ];then 
                echo "ceci est presque la fin de la story 9"
                # si trop gros => kill du PID => copier fichiers etc => PID=0
                kill $!
                fi
        fi                

sleep 5
done

if [ -e /home/$USER/$Dir/ ];then

        echo "le fichier existe"

 else

          echo "le fichier n'existe pas garçon!"       
fi        