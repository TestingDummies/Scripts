#!/bin/bash
clear
mandarlogFIREWALL() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando $1" >> /opt/Scripts/Logs/FIREWALL_log.txt
}

menu_ip() {
	echo "MENU PRINCIPAL"
	echo "Recuerda, todos los cambios se hacen en la zona publica"
	echo "1) Permitir una IP"
	echo "2) Bloquear una IP"
	echo "3) Recargar firewall"
	echo "4) Ver reglas de la zona"
	echo "5) Salir"

	read -p "Seleccione una opcion: " opcion

	case $opcion in
		1) 
			read -p "Escriba la ip que desea permitir: " permitirip
				sudo firewall-cmd --permanent --zone=public --add-source="$permitirip"
					mandarlogFIREWALL "sudo firewall-cmd --permanent --zone=public --add-source=$permitirip"
						menu_ip
		;;
		2) 
			read -p "Escriba la ip que desea bloquear: " bloquearip
				sudo firewall-cmd --permanent --zone=public --remove-source="$bloquearip"
					mandarlogFIREWALL "sudo firewall-cmd --permanent --zone=public --remove-source=$bloquearip"
						menu_ip
			;;
		3) 
			firewall-cmd --reload
				mandarlogFIREWALL "firewall-cmd --reload"
					menu_ip
			;;
		4) 
			firewall-cmd --list-all
			mandarlogFIREWALL "firewall-cmd --list-all"
			menu_ip
			;;
		5)
			exit
			;;
		*) 
			echo "Opcion no valida."
				menu_ip
			;;
	esac
}
	menu_ip
