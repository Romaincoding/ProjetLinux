#!/bin/bash
#set -x

timer=$1
Dir=$2
fileName1=$3
fileName2=$4
fileSize=$5



if [ -e /home/$USER/$Dir ];then

        echo "le fichier existe"

 else

          echo "le fichier n'existe pas garçon!"       
fi        