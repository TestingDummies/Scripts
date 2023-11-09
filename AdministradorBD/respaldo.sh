#!/bin/bash
clear
mandarlogBACKUP() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando $1" >> /opt/Scripts/Logs/RESPALDO_log.txt
}

menu_respaldo() {
	echo "MENU PRINCIPAL"
	echo "1) Respaldo local"
	echo "2) Respaldo remoto"
	echo "3) Respaldo local de la BD"
	echo "4) Respaldo remoto de la BD"
	echo "5) Salir"

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
			read -p "Escriba el nombre del contenedor MYSQL del docker: " nomcontainer
			reap -p "Escribe el nombre de la base de datos: " nombd
			read -p "Escibre en que ruta quieres que se guarde (Barra en el final y al principio): " ruta
			
			docker exec -i $nomcontainer mysqldump -u root -p $nombd > "$ruta"respaldokarate_$(date +"%d-%m-%Y").sql
			mandarlogBACKUP "docker exec -i $nomcontainer mysqldump -u root -p $nombd > "$ruta"respaldokarate_$(date +"%d-%m-%Y").sql"
			;;

		4) 
		read -p "Escriba el nombre del contenedor MYSQL del docker: " nomcontainer
		read -p "Escribe el nombre de la base de datos: " nombd
		read -p "Escriba la IP del servidor remoto: " ipruta
		read -p "Escriba el nombre de su usuario en el servidor remoto: " nomrem
		read -p "Escriba en que ruta quieres que se guarde (Barra en el final y al principio): " rutadest
		docker exec -i $nomcontainer mysqldump -u root -p $nombd > respaldokarate_$(date +"%d-%m-%Y").sql && rsync -av respaldokarate_$(date +”%d-%m-%Y”).sql "$nomrem"@"$ipruta":$rutadest
		mandarlog "docker exec -i $nomcontainer mysqldump -u root -p $nombd > respaldokarate_$(date +"%d-%m-%Y").sql && rsync -av respaldokarate_$(date +”%d-%m-%Y”).sql "$nomrem"@"$ipruta":$rutadest"
		;;
		5)
		exit
		;;
		*)
			echo "Opcion no valida."
			;;
		esac
	}

menu_respaldo
