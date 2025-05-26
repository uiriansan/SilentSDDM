#!/bin/sh
green='\033[0;32m'
reset="\033[0m"

echo -e "${green}Testing Silent theme...${reset}\nDon't worry about the infinite loading, SDDM won't let you log in while in 'test-mode'.\n\n"

QT_IM_MODULE=qtvirtualkeyboard QML2_IMPORT_PATH=./components/ sddm-greeter-qt6 --test-mode --theme .
