#!/bin/bash
clear
mandarlogRED() {
	echo "$(date "+%Y-%m-%d %H:%M:%S") - El usuario $(whoami) uso el comando: $1" >> /opt/Scripts/Logs/RED_log.txt
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
menu_redes