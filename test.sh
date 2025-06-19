#!/bin/bash
green='\033[0;32m'
red='\033[0;31m'
bred='\033[1;31m'
cyan='\033[0;36m'
grey='\033[2;37m'
reset="\033[0m"

# Generate timestamp for unique log files
timestamp=$(date +"%Y%m%d-%H%M%S")

# Test for debug param ( debug | -debug | -d | --debug )
if [[ "$1" =~ ^(debug|-debug|--debug|-d)$ ]]; then
    debug_log="test-debug-${timestamp}.log"
    echo -e "${cyan}Debug mode - logging to ${debug_log}${reset}"
    QT_IM_MODULE=qtvirtualkeyboard QML2_IMPORT_PATH=./components/ sddm-greeter-qt6 --test-mode --theme . 2>&1 | tee "$debug_log"
else
    test_log="test-${timestamp}.log"
    config_file=$(awk -F '=' '/^ConfigFile=/ {print $2}' metadata.desktop)
    echo -e "${green}Testing Silent theme with Enhanced Features...${reset}"
    echo -e "Loading config: ${cyan}${config_file}${reset}"
    echo -e "\n${cyan}✨ Enhanced Features Active:${reset}"
    echo -e "  ${grey}•${reset} Smooth animations and transitions"
    echo -e "  ${grey}•${reset} Hover effects on buttons"
    echo -e "  ${grey}•${reset} Ripple animations on click"
    echo -e "  ${grey}•${reset} Smart avatar fallbacks"
    echo -e "  ${grey}•${reset} Enhanced error feedback"
    echo -e "\nDon't worry about the infinite loading, SDDM won't let you log in while in 'test-mode'."
    echo -e "Logs saved to: ${cyan}${test_log}${reset}\n"
    QT_IM_MODULE=qtvirtualkeyboard QML2_IMPORT_PATH=./components/ sddm-greeter-qt6 --test-mode --theme . > "$test_log" 2>&1 &
    echo -e "Test running in background (PID: $!). Check ${test_log} for details."
    
    # Keep latest log as test.log for compatibility
    ln -sf "$test_log" test.log
fi

if [ ! -d "/usr/share/sddm/themes/silent" ]; then
    echo -e "\n${bred}[WARNING]: ${red}theme not installed!${reset}"
    echo -e "Run ${cyan}'./install.sh'${reset} or copy the contents of the theme to ${cyan}'/usr/share/sddm/themes/silent/'${reset} and set the current theme to ${cyan}'silent'${reset} in ${cyan}'/etc/sddm.conf'${reset}:\n"
    echo -e "    ${grey}# /etc/sddm.conf${reset}"
    echo -e "    [Theme]"
    echo -e "    Current=silent"
fi
