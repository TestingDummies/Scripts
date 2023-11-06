#!/bin/bash
clear
mandarlogBACKUP() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando $1" >> /opt/Scripts/Logs/RESPALDO_log.txt
}

menu_respaldo() {
	echo "MENU PRINCIPAL"
	echo "1) Respaldo local"
	echo "2) Respaldo remoto"
	echo "3) Salir"

	read -p "Seleccione una opcion: " opcion

	case $opcion in
		1) 
			read -p "Escriba la ruta del directorio que quieres respaldar: " lrespaldo
			read -p "Escriba la ruta del destino del respaldo: " ldestino
				rsync -avz "$lrespaldo" "$ldestino"
					mandarlogBACKUP "rsync -avz $lrespaldo $ldestino"
			;;
		2)
			read -p "Escriba la ruta del directorio que quieres respaldar: " rrespaldo
			read -p "Escriba la ruta del destino del respaldo: " rdestino
			read -p "Escriba la ip de la red SSH: " rdireccion
			read -p "Escriba el nombre de su usuario en la red: " rusuario
				rsync -avz -e "$rrespaldo" "$rusuario@$rdireccion:$rdestino"
					mandarlogBACKUP "rsync -avz -e $rrespaldo $rusuario@$rdireccion:$rdestino"
			;;
		3) 	
			exit
			;;
		*)
			echo "Opcion no valida."
			;;
		esac
	}

menu_respaldo
