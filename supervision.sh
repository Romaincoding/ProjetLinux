#!/bin/bash
set -x

#list of args timer is the time between the display, 
#Dir is for the directory the we create
#fileName1 is one of the log file the we create
#fileName2 is one of the log file the we create
#fileSize is the maximum size the we set for the log's file

timer=$1
Dir=$2
fileName1=$3
fileName2=$4
fileSize=$5

generationPID=0
version=0



# Start of the infinite loop
while true;do
# verifier qui est l'utilisateur courant et recuprerla taille des fichiers de logs
# get back the log file and calculate its size
testSize=$(du /home/$USER/$Dir/$fileName1.log | cut -f1);
# get back the log file and calculate its size
testSizeError=$(du /home/$USER/$Dir/$fileName2.log | cut -f1);

#message si le dossier n'existe pas ou si le script n'est pas lancé
#process = $(pgrep generation.sh)
#if [[ $process -eq 0 ]]; then 
#        echo " coucou tu veux voir mon process ? je ne suis pas lancé"
#fi

#testSizeCut=$(echo $testSize | cut -d "k")
#verify if "generation.sh" is launched and launch it , if it's not done  
        if [[ $generationPID -eq 0 ]]; then
                ./generation.sh $timer $Dir $fileName1 $fileName2 &
                generationPID=$!

#regarder si le sfichiers de logs pas trop gros => methode
                sleep 1        
        fi
#regarder le code d'erreur du pgrep
        pgrep generation.sh
        echo $?
        #test si ca renvoie 1 ou 0 => ensuite l'inclure dans la condition


#condition where we verify if logfile's size are greater than the size set in argument $fileSize
        if [[ $testSize -gt $fileSize || $testSizeError -gt $fileSize ]]; then 

                echo "la taille du fichier est trop grande. Enclenchement procedure archive"
                # si trop gros => kill du PID => copier fichiers etc => PID=0
                # if the size is greater : get back the genereation.sh PIDS and kill them
                pgrep generation.sh | xargs kill
                date=$(date '+%Y-%m-%d')

                cut -d: -f2,3,4,5 /home/$USER/$Dir/$fileName1.log | sort -n -o /home/$USER/$Dir/$fileName1.log
                exit 0
                # count numberts of records in logfiles 
                # save this count in a new file with name numberInLog
                touch /home/$USER/$Dir/numberInLog.txt
                wc -l /home/$USER/$Dir/$fileName1.log >> /home/$USER/$Dir/numberInLog.txt  
                wc -l /home/$USER/$Dir/$fileName2.log >> /home/$USER/$Dir/numberInLog.txt

                # compress the logfiles and numberInLog in the same directory     
                cd /home/$USER/$Dir
                tar -czvf $date.tar.gz *.log *.txt
                cd -
                # delete the files before reinitialize 
                rm /home/$USER/$Dir/*.log
                rm /home/$USER/$Dir/*.txt
                #reinitialize the PID to 0
                generationPID=0
        fi


sleep 5
done

if [ -e /home/$USER/$Dir/ ]; then

        echo "le fichier existe"


 else

          echo "le fichier n'existe pas garçon!"
fi