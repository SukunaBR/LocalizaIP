#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'

function banner(){
echo -e ${RED}"##################################################################"                                                    
echo -e ${CP}"                    LOCALIZADOR DE ENDEREÇO IP                   #"
echo -e ${CP}"                                                                 #"                                                 
echo -e ${YELLOW}"                   Made By MP Server Inc.                        #"
echo -e ${CNC}"                   https://github.com/SukunaBR                   #"
echo -e ${RED}"##################################################################"
}
function requiredstuff(){
echo "Verificando as configurações" 
sleep 1
if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
  echo ${RED}"Sem conexão de internet"
  exit 1
  else
  echo -e ${GREEN} "\n[ ✔ ] Internet.............${GREEN}[ funcionando ]"
fi
sleep 1
which jq > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${GREEN} "\n[ ✔ ] jq.............${GREEN}[ encontrado ]"
else
echo -e $red "[ X ] jq  -> ${RED}não encontrado "
echo -e ${YELLOW} "[ ! ] Instalando jq "
sudo apt-get install jq
echo -e ${BLUE} "[ ✔ ] Instalação finalizada ...."
fi
sleep 1
which curl > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e ${GREEN} "\n[ ✔ ] curl.............${GREEN}[ encontrado ]"
else
echo -e $red "[ X ] curl  -> ${RED}não encontrado "
echo -e ${YELLOW} "[ ! ] Instalando curl "
sudo apt-get install curl
echo -e ${BLUE} "[ ✔ ] Instalação finalizada ...."
fi
sleep 1
}
function exposeip(){
echo -e -n ${CP}"\n[*] Digite o endereço IP: "
read ip
dest="http://ip-api.com/json/"
echo -e -n ${RED}"\n[ ✔ ] [ENDEREÇO IP]: $ip \n"

temp=$(curl -s $dest$ip | jq  -r '.country')
echo -e -n ${NEW}"\n[ ✔ ] [PAÍS]:  $temp \n"
temp=$(curl -s $dest$ip | jq  -r '.regionName')
echo -e -n ${ORANGE}"\n[ ✔ ] [REGIÃO]:  $temp \n"
temp=$(curl -s $dest$ip | jq  -r '.city')
echo -e -n ${PINK}"\n[ ✔ ] [CIDADE]:  $temp \n"
temp=$(curl -s $dest$ip | jq  -r '.lat')
echo -e -n ${YELLOW}"\n[ ✔ ] [LATITUTE]:  $temp \n"
temp=$(curl -s $dest$ip | jq  -r '.lon')
echo -e -n  ${BLUE}"\n[ ✔ ] [LONGITUDE]:  $temp \n"
temp=$(curl -s $dest$ip | jq  -r '.isp')
echo -e -n ${CG}"\n[ ✔ ] [ISP]:  $temp \n"
temp=$(curl -s $dest$ip | jq  -r '.as')
echo -e -n ${CN}"\n[ ✔ ] [AS]:  $temp \n"
temp=$(curl -s $dest$ip | jq  -r '.timezone')
echo -e -n ${CP}"\n[ ✔ ] [FUSO HORÁRIO]:  $temp \n"
temp=$(curl -s $dest$ip | jq  -r '.zip')
echo -e -n ${YELLOW}"\n[ ✔ ] [CÓDIGO POSTAL]:  $temp \n"
sleep 1
echo -e -n ${RED}"\n<--------OBRIGADO POR USAR LOCALIZA IP!--------->\n"


}
clear
requiredstuff
clear
banner
exposeip
