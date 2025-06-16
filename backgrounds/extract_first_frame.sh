#!/bin/bash
green='\033[0;32m'
red='\033[0;31m'
cyan='\033[0;36m'
reset="\033[0m"

if [[ ! -f "$1" ]]; then
    echo -e "Usage: ./extract_first_frame.sh ${cyan}<background_video>${reset}"
    exit
fi

ffmpeg -i "$1" -vf "select=eq(n\,34)" -vframes 1 $(basename backgrounds/ken.mp4 | cut -d"." -f1).png
