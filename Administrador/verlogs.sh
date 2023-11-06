#!/bin/bash

menu_logs() {
	echo "MENU PRINCIPAL"
	echo "1) Ver logs de ABM de usuarios y grupos"
	echo "2) Ver logs de respaldo"
	echo "3) Ver logs de filtrado de ips"
    echo "4) Ver logs de los comandos de red"
	echo "5) Salir"

	read -p "Seleccione una opcion: " opcion

	case $opcion in
		1) 
			cat /opt/Scripts/Logs/ABM_log.txt
			
		;;
		2)
            cat /opt/Scripts/Logs/RESPALDO_log.txt

			;;
		3) 
			cat /opt/Scripts/Logs/FIREWALL_log.txt

			;;
		4) 
            cat /opt/Scripts/Logs/RED_log.txt

			;;

		5) 
			cat /opt/Scripts/Logs/SERVICIOS_log.txt
		;;

		6) exit
		;;

		*) 
            echo "Opcion no valida."
		
			;;
	esac
}
	menu_logs
