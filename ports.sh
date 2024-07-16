#!/bin/bash

#Colours


greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Ctrl + C

function ctrl_c() {
    echo -e "\n${redColour}[!] Saliendo...${endColour}"
    exit 1
}

trap ctrl_c INT

# Comprobamos si el script se ejecuta como root

if [ $(id -u) -ne 0 ]; then
    echo -e "\n${redColour}[!] Debes ejecutar el script como root${endColour}\n"
    exit 1
fi


# Help Panel


function helpPanel() {
	echo -e "${yellowColour}[!]${endColour} ${grayColour}Uso: ./ports.sh ${endColour}"
	echo -e "[+] ${grayColour}Opciones:${endColour}"

	echo -e "\n\t${yellowColour}[+]${endColour}${grayColour} -h${endColour} ${turquoiseColour}Mostrar este panel de ayuda${endColour}\n"
	echo -e "\n\t${yellowColour}[+]${endColour}${grayColour} -o${endColour} ${turquoiseColour}Mostrar los puertos abiertos${endColour}\n"
	exit 1

}

function openPorts() {

	let ip=0

	echo -e "\n${yellowColour}[!]${endColour}${grayColour} Introduce la IP:${endColour}"

	read ip

	echo -e "\n${yellowColour}[+]${endColour} ${greenColour}Escaneando puertos, por favor espera :) ...${endColour}"

# Verificamos que la variable ip tenga un valor

if [ -z $ip ]; then
	echo -e "\n${redColour}[!] Debes introducir una IP${endColour}\n"
	exit 1
fi

	scanOpen=$(nmap -p- --open -sS -n -vvv --min-rate 5000 $ip | grep -i "open")
	
	open_ports=''
	
	while read -r port; do

		open_ports+="$port "	

	done <<< "$scanOpen"

	echo 	

	if [ -n "$open_ports" ]; then

		

		echo -e "\n${yellowColour}[!]${endColour}${grayColour} Puertos abiertos en la IP:${endColour} ${turquoiseColour}$ip${endColour}\n"

		echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Puertos:${endColour} ${grayColour}$open_ports ${endColour}\n"
	
		exit 0
	
	else
		echo -e "\n${redColour}[!] No se han encontrado puertos abiertos en la IP:${endColour} ${turquoiseColour}$ip${endColour}\n"
		exit 1
	fi

}




# Main Function


declare -i parameter_counter=0; while getopts ":h:o" arg; do
	case $arg in
		o) openPorts && parameter_counter+=1;;
		h) helpPanel;;
	esac
done

# Comprobamos si se han pasado argumentos
if [ $parameter_counter -eq 0 ]; then	
	helpPanel
elif [ $parameter_counter -eq 1 ]; then
	openPorts
fi

