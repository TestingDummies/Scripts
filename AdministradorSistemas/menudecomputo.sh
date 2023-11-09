#!/bin/bash
clear
mandarlogABM() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando $1" >> /opt/Scripts/Logs/ABM_log.txt
}

errorlog1() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) intento usar una de las funciones "A.B.M USUARIO" sin exito" >> /opt/Scripts/Logs/ABM_log.txt
}

errorlog2() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) intento usar una de las funciones "A.B.M GRUPO" sin exito." >> /opt/Scripts/Logs/ABM_log.txt
}

errorlog3() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) intento usar la funcion "Añadir un usuario a un grupo" sin exito." >> /opt/Scripts/Logs/ABM_log.txt
}
mandarlogBACKUP() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando $1" >> /opt/Scripts/Logs/RESPALDO_log.txt
}
mandarlogFIREWALL() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando $1" >> /opt/Scripts/Logs/FIREWALL_log.txt
}
mandarlogRED() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando: $1" >> /opt/Scripts/Logs/RED_log.txt
}
mandarlogSERVICIOS() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando: $1" >> /opt/Scripts/Logs/SERVICIOS_log.txt
}

menudecomputo() {
echo "BIENVENIDO AL CENTRO DE COMPUTO"
echo "1) A.B.M DE USUARIOS Y GRUPOS"
echo "2) RESPALDOS LOCALES Y REMOTOS"
echo "3) FILTRADO DE IPS"
echo "4) COMANDOS DE RED"
echo "5) VER Y ANALIZAR SERVICIOS"
echo "6) VER LOG DE LOS SCRIPTS"
echo "7) VER LOG DE AUDITORIA"
echo "8) SALIR"
read -p "Elija una opcion: " opcion

case $opcion in

1) 
menu_abm
;;

2) 
menu_respaldo
;;

3) 
menu_ip
;;

4) 
menu_redes
;;

5) 
menu_servicios
;;

6) 
menu_logs
;;

7) 
menu_auditoria
;;

8) 
exit
;;

*) 
echo "Opcion incorrecta."
;;
esac
}

menu_abm() {
	echo "MENU DE A.B.M"
	echo "1) A.B.M USUARIO"
	echo "2) A.B.M GRUPO"
	echo "3) Añadir un usuario a un grupo"
	echo "4) salir"
	
	read -p "Seleccione una opcion: " opcion

	case $opcion in
		1)
			usuario
			;;
		2)
			grupo
			;;

		3)	
			read -p "Escriba el nombre del usuario: " usuariomod
				if getent passwd "$usuariomod" >/dev/null; then
					read -p "Escriba el nombre del grupo al que quiere agregar al usuario: " grupomod
						if getent group "$grupomod" >/dev/null; then
								usermod -aG "$grupomod" "$usuariomod"
								echo "Su usuario fue agregado al grupo dado."
									mandarlogABM "usermod -aG $grupomod $usuariomod"	

				else
								echo "El grupo no existe."
									errorlog3
			fi
			else
				echo "El usuario no existe."
					errorlog3
			fi
			;;	

		4)	
			exit
			;;
		*)
			echo "Opcion no valida."
			;;
		esac
}
usuario() {
	echo "A.B.M USUARIOS"
	echo "a) AGREGAR USUARIO"
	echo "b) BORRAR USUARIO"
	echo "c) MODIFICAR USUARIO"
	echo "d) VOLVER"

	read -p "Seleccione una opcion: " useropcion

	case $useropcion in
	a)
		read -p "Escriba el nombre para el usuario: " usuarionom
		if getent passwd "$usuarionom" >/dev/null; then
			echo "El usuario ya existe."
				errorlog1
		else
			useradd "$usuarionom"
			echo "El usuario ha sido creado."
				mandarlogABM "useradd $usuarionom"
		fi
		;;
	b)
		read -p "Escriba el nombre del usuario que quiere borrar: " usuarionomb
		if getent passwd "$usuarionomb" >/dev/null; then
			userdel "$usuarionomb"
			echo "El usuario ha sido borrado."
				mandarlogABM "userdel $usuarionomb"
		else
			echo "El usuario que intentas borrar no existe."
				errorlog1
		fi
		;;
	c)
		read -p "Escriba el nombre del usuario que quiere modificar: " usuarionomc
		if getent passwd "$usuarionomc" >/dev/null; then
			read -p "Escriba el nombre nuevo de tu usuario: " usuarionomn
				usermod -l "$usuarionomn" "$usuarionomc"
				echo "El nombre de su usuario ha sido modificado."
					mandarlogABM "usermod -l $usuarionomn $usuarionomc"
		else
			echo "El usuario que intentas modificar no existe."
				errorlog1
		fi
		;;
	d)
		menu_abm
		;;
	*)
		echo "no valido"
		;;
	esac
}

grupo() {
	echo "A.B.M GRUPOS"
	echo "a) AGREGAR GRUPO"
	echo "b) BORRAR GRUPO"
	echo "c) MODIFICAR GRUPO"
	echo "d) VOLVER"

	read -p "Seleccione una opcion: " grupoopcion

	case $grupoopcion in
	a)
		read -p "Escriba el nombre para el grupo: " gruponom
		if getent group "$gruponom" >/dev/null; then
			echo "El grupo ya existe."
				errorlog2
		else
			groupadd "$gruponom"
			echo "El grupo ha sido creado."
				mandarlogABM "groupadd $gruponom"
		fi
		;;
	b)
		read -p "Escriba el nombre del grupo que quiere borrar: " gruponomb
		if getent group "$gruponomb" >/dev/null; then
			groupdel "$gruponomb"
			echo "El grupo ha sido borrado."
				mandarlogABM "groupdel $gruponomb"	
		else
			echo "El grupo que intentas borrar no existe."
				errorlog2
		fi
		;;
	c)
		read -p "Escriba el nombre del grupo que quiere modificar: " gruponomc
		if getent group "$gruponomc" >/dev/null; then
			read -p "Escriba el nombre nuevo de tu grupo: " gruponomn
				groupmod -n "$gruponomn" "$gruponomc"
				echo "El nombre de su grupo ha sido modificado."
					mandarlogABM "groupmod -n $gruponomn $gruponomc"
		else
			echo "El grupo que intentas modificar no existe."
				errorlog2
		fi
		;;
		
	d)
		menu_abm
		;;
	*)
		echo "no valido"
		;;
	esac
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

menu_redes(){
echo "Menu de redes"
echo "1) Ver conexiones de red"
echo "2) Ver el nombre de mi red"
echo "3) Cambiar ip"
echo "4) Apagar red" 
echo "5) Encender red"
echo "6) Ping a una pagina o IP"
echo "7) Verificar la ruta de paquetes a una pagina o IP"
echo "8) Ver informacion de una pagina"
echo "9) Ver puertos de una IP"
echo "10) Examinar configuraciones en la red"
echo "11) Hacer consulta DNS a una pagina"
echo "12) Ver el codigo fuente de una pagina con curl"
echo "13) Información del host actual"
echo "14) Salir"
read -p "Seleccione una opción: " opcion
case $opcion in
1) nmcli connection show
    mandarlogRED "nmcli connection show"
    ;;

2) read -p "Escriba el nombre de su red: " variable
    ip addr show $variable
    mandarlogRED "ip addr show $variable"
    ;;
3) echo "Entraste a la configuración de la IP"
echo "Recuerda, estos cambios son TEMPORALES, al apagar el sistema se reiniciaran. Si quieres hacer un cambio permanente debes consultar el documento"
    read -p "¿Cual es el nombre de la red a cambiar?: " nombrered
    read -p "¿Cual va a ser su nueva ip?: " variableip
    read -p "¿Cual va a ser su nueva mascara?: " variablemasc
    nmcli connection modify $nombrered IPv4.method manual
    nmcli connection modify $nombrered IPv4.address $variableip/$variablemasc
    mandarlogRED "nmcli connection modify $nombrered IPv4.address $variableip/$variablemasc"
    read -p "¿Cual va a ser su nueva puerta de enlace?: " variablepuerta
    nmcli connection modify $nombrered IPv4.gateway $variablepuerta
    mandarlogRED "nmcli connection modify $nombrered IPv4.gateway $variablepuerta"
    read -p "¿Cual va a ser su nuevo DNS?: " variabledns
    nmcli connection modify $nombrered IPv4.dns $variabledns
    mandarlogRED "nmcli connection modify $nombrered IPv4.dns $variabledns"
    echo "Listo! si quieres que los cambios surjan efecto debes reiniciar la red."
    ;;
4) read -p "¿Cual red quieres apagar? escibre su nombre: " nombrered
    nmcli connection down $nombrered
    mandarlogRED "nmcli connection down $nombrered"
;;
5) 
 read -p "¿Cual red quieres encender? escibre su nombre: " nombrered
    nmcli connection up $nombrered
    mandarlogRED "nmcli connection up $nombrered"
;;

6) 
 read -p "Escriba la IP o pagina (url) a la que quiere hacer ping: " variableping
        traceroute $variableping
        mandarlogred "traceroute $variableping"
;;

7) 
    read -p "Escriba la IP o pagina (url) para verificar ruta: " variable
        traceroute $variable
            mandarlogRED "traceroute $variable"
;;

8) 
    read -p "Escriba el url de la que quiere saber informacion: " variable
        whois $variable
            mandarlogRED "whois $variable"
;;

9) 
    read -p "Escriba la ip para ver los puertos abiertos: " variable
        nmap $variable
            mandarlogRED "nmap $variable"
;;

10) 
    netstat
        mandarlogRED "netstat"
;;

11) 
    read -p "Escriba el url de la pagina o ip a la que quiere hacer una consulta DNS: " variable
        nslookup $variable
            mandarlogRED "nslookup $variable"
;;

12) 
    read -p "¿A que pagina (url) quieres hacerle curl? (Mostrar codigo fuente de la pagina): " variable
        curl $variable
            mandarlogRED "curl $variable"
;;

13) 
    hostname
        mandarlogRED "hostname"
;;
14) 
    exit
;;

*) 
    echo "Opcion invalida"
;;

esac
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
			cat /Scripts/Logs/ABM_log.txt
			
		;;
		2) 
            cat /Scripts/Logs/RESPALDO_log.txt

			;;
		3) 
			cat /Scripts/Logs/FIREWALL_log.txt

			;;
		4) 
            cat /Scripts/Logs/RED_log.txt

			;;
		5) exit
		;;
		*) 
            echo "Opcion no valida."
		
			;;
	esac
}

mandarlogAUDITORIA() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando: $1" >> /opt/Scripts/Logs/AUDIT_log.txt
}
menu_auditoria() {
    echo "1) Ver logs de agregacion de usuarios (useradd)"
    echo "2) Ver logs de eliminacion de usuarios (userdel)"
    echo "3) Ver logs de modificacion de usuarios (usermod)"
    echo "4) Ver logs de agregacion de grupos (gropadd)"
    echo "5) Ver logs de eliminacion de grupos (groupdel)"
    echo "6) Ver logs de modificacion de grupos (groupmod)"
    echo "7) Ver logs de los servicios (systemctl)"
    echo "8) Ver logs del firewall (firewall-cmd)"
    echo "9) Ver logs del servidor (sshd)"
    echo "10) Ver logs de comandos hechos con permisos de superusuario (sudo)"
    echo "11) Ver logs de instalacion y actualizacion (DNF)"
    echo "12) Ver logs de instalacion y actualizacion (YUM)"
    echo "13) Salir"
    read -p "Elija una opcion: " opcion
    
    case $opcion in
    1) journalctl | grep 'useradd'
    ;;

    2) journalctl | grep 'userdel'
    ;;

    3) journalctl | grep 'usermod'
    ;;

    4) journalctl | grep 'groupadd'
    ;;

    5) journalctl | grep 'groupdel'
    ;;

    6) journalctl | grep 'groupmod'
    ;;

    7) journalctl | grep 'systemctl'
    ;;

    8) journalctl | grep 'firewall-cmd'
    ;;

    9) journalctl | grep 'sshd'
    ;;

    10) journalctl | grep 'sudo'
    ;;

    11) journalctl | grep 'dnf'
    ;;

    12) journalctl | grep 'yum'
    ;;

    13) exit
    ;;
    esac
}

menudecomputo