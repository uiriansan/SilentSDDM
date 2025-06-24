#!/usr/bin/env bash
green='\033[0;32m'
red='\033[0;31m'
cyan='\033[0;36m'
reset="\033[0m"

print_help () {
    echo -e "Usage: ./change_avatar.sh ${cyan}<username> <path_to_image>${reset}"
}
if [ "$#" -ne 2 ]; then
    print_help
    exit
fi

USERNAME="$1"
IMAGE="$2"

if ! id "$USERNAME" >/dev/null 2>&1; then
    echo -e "${red}User '$USERNAME' not found!${reset}"
    print_help
    exit
fi

if [[ ! -f "$IMAGE" ]]; then
    echo -e "${red}Invalid image file!${reset}"
    print_help
    exit
fi

if [[ -f "/usr/share/sddm/faces/$USERNAME.face.icon" ]]; then
    echo -e "${green}Creating backup for '/usr/share/sddm/faces/$USERNAME.face.icon'${reset}"
    sudo cp -f "/usr/share/sddm/faces/$USERNAME.face.icon" "/usr/share/sddm/faces/$USERNAME.face.icon.bkp"
fi

sudo cp "$IMAGE" "/usr/share/sddm/faces/tmp_face"
# Crop image to square:
sudo mogrify -gravity center -crop 1:1 +repage "/usr/share/sddm/faces/tmp_face"
# Resize face to 256x256:
sudo mogrify -resize 256x256 "/usr/share/sddm/faces/tmp_face"
sudo mv "/usr/share/sddm/faces/tmp_face" "/usr/share/sddm/faces/$USERNAME.face.icon"

echo -e "\n${green}Avatar updated for user '$USERNAME'!${reset}"
