#!/bin/bash
clear
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
menu_auditoria