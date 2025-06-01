#!/bin/sh
green='\033[0;32m'
red='\033[0;31m'
bred='\033[1;31m'
cyan='\033[0;36m'
grey='\033[2;37m'
reset="\033[0m"

echo -e "${green}Testing Silent theme...${reset}\nDon't worry about the infinite loading, SDDM won't let you log in while in 'test-mode'.\n------------------------------------------------------------"

QT_IM_MODULE=qtvirtualkeyboard QML2_IMPORT_PATH=./components/ sddm-greeter-qt6 --test-mode --theme .

if [ ! -d "/usr/share/sddm/themes/silent" ]; then
    echo -e "\n${bred}[WARNING]: ${red}theme not installed!${reset}"
    echo -e "Run ${cyan}'./install.sh'${reset} or copy the contents of the theme to ${cyan}'/usr/share/sddm/themes/silent/'${reset} and set the current theme to ${cyan}'silent'${reset} in ${cyan}'/etc/sddm.conf'${reset}:\n"
    echo -e "    ${grey}# /etc/sddm.conf${reset}"
    echo -e "    [Theme]"
    echo -e "    Current=silent"
fi
