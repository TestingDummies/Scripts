#!/bin/bash
clear
mandarlogSERVICIOS() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando: $1" >> /opt/Scripts/Logs/SERVICIOS_log.txt
}

menu_servicios() {
	echo "MENU PRINCIPAL"
	echo "1) Ver el estado de un servicio"
	echo "2) Iniciar servicio"
	echo "3) Listar servicios"
	echo "4) Detener servicio"
	echo "5) Habilitar servicio"
	echo "6) Deshabilitar servicio"
	echo "7) Salir"
	read -p "Seleccione una opcion: " opcion

	case $opcion in
		1) read -p "¿De que servicio quieres ver su estado?: " servicioestado
			systemctl status $servicioestado
			mandarlogSERVICIOS "systemctl status $servicioestado"
			;;
		2) read -p "¿Que servicio queres quieres iniciar?: " servicioinic
			systemctl start $servicioinic
			mandarlogSERVICIOS "systemctl start $servicioinic"
			;;
		3) systemctl list-units
		mandarlogSERVICIOS "systemctl list-units"
		;;

		4) read -p "¿Que servicio quieres detener?: " serviciodeten
		systemctl stop $serviciodeten
		mandarlogSERVICIOS "systemctl stop $serviciodeten"
		;;
		5) read -p "¿Que servicio quieres habilitar?: " serviciohab
		systemctl enable serviciohab
		mandarlogSERVICIOS "systemctl enable serviciohab"
		;;
		6) read -p "¿Que servicio quieres deshabilitar?: " serviciodeshab
		systemctl disable serviciodeshab
		mandarlogSERVICIOS "systemctl disable serviciodeshab"
		;;
		7) exit
		;;
		*) echo "Opcion invalida."
		;;
	esac
}
menu_servicios


