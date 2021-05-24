#!/bin/bash
if [ -z $1 ]
then
	echo "--------------------------------------------------------------"
	echo -e "\t\t\tWEB RECON"
	echo "--------------------------------------------------------------"
	echo -e "Modo de uso: ./webrecon.sh [dominio] [extensão_arquivo] \n- Poderão ser passados mais de uma extensão por paramentro, separadas por espaço \n- A extensão de arquivos é opcional"
else
	echo "--------------------------------------------------------------"
	echo -e "\t\t\t DIRETORIOS"
	echo "--------------------------------------------------------------"

	for word in $(cat word_list_web_recon) 
	do
		resp=$(curl -s -H "User-Agent: Firefox" -o /dev/null -w "%{http_code}" $1/$word/)
		if [ $resp == "200" ]
		then
			echo "$1/$word"
		fi
	done
	
	if [ "$2" != "" ]
	then
		echo "--------------------------------------------------------------"
		echo -e "\t\t\t ARQUIVOS"
		echo "--------------------------------------------------------------"

		for word in $(cat word_list_web_recon)
		do
			for i in $@
			do
				resp=$(curl -s -H "User-Agent: Firefox" -o /dev/null -w "%{http_code}" $1/$word.$i)
				if [ $resp == "200" ]
				then
					echo "$1/$word.$i"
				fi
			done
		done
	fi
fi
