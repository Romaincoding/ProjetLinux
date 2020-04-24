#!/bin/bash
set -x

timer=$1
Dir=$2
fileName1=$3
fileName2=$4
fileSize=$5

generationPID=0
version=0



# 1) declarer un generationPID=0
while true;do
# verifier qui est l'utilisateur courant et recuprerla taille des fichiers de logs
testSize=$(du /home/$USER/$Dir/$fileName1.log | cut -f1);
testSizeError=$(du /home/$USER/$Dir/$fileName2.log | cut -f1);

#message si le dossier n'existe pas ou si le script n'est pas lancé
#process = $(pgrep generation.sh)
#if [[ $process -eq 0 ]]; then 
#        echo " coucou tu veux voir mon process ? je ne suis pas lancé"
#fi

#testSizeCut=$(echo $testSize | cut -d "k")
#verifier que generation.sh n'existe pas=> si generatiopnPID=0, il faut le lancer 
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

        if [[ $testSize -gt $fileSize || $testSizeError -gt $fileSize ]]; then 

                echo "la taille du fichier est trop grande. Enclenchement procedure archive"
                # si trop gros => kill du PID => copier fichiers etc => PID=0
                #kill $generationPID
                pgrep generation.sh | xargs kill
                date=$(date '+%Y-%m-%d')

                cut -d: -f2,3,4,5 /home/$USER/$Dir/$fileName1.log | sort -n -o /home/$USER/$Dir/$fileName1.log
                exit 0
                # comptage du nombres enregistrements dans fichiers 1 et 2
                # et enregistrement dans un fichier numberInLog
                touch /home/$USER/$Dir/numberInLog.txt
                wc -l /home/$USER/$Dir/$fileName1.log >> /home/$USER/$Dir/numberInLog.txt  
                wc -l /home/$USER/$Dir/$fileName2.log >> /home/$USER/$Dir/numberInLog.txt

                # archivage des logs dans le même repertoire et du fichier numberInLog       
                cd /home/$USER/$Dir
                tar -czvf $date.tar.gz *.log *.txt
                cd -
                # suppression des fichiers d'origine avant reinit du process 
                rm /home/$USER/$Dir/*.log
                rm /home/$USER/$Dir/*.txt
                #reinit du PID
                generationPID=0
        fi


sleep 5
done

if [ -e /home/$USER/$Dir/ ]; then

        echo "le fichier existe"


 else

          echo "le fichier n'existe pas garçon!"
fi