#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
METADATA="$SCRIPT_DIR/metadata.desktop"

# ── Colors using printf \e ────────────────────────────────────
c() { printf '\e[%sm' "$1"; }
reset=$(c 0)
green=$(c '0;32m')
red=$(c '0;31m')
cyan=$(c '0;36m')
yellow=$(c '1;33m')
white=$(c '1;37m')
grey=$(c '2;37m')
bold=$(c '1m')
dim=$(c '2m')

INSTALL_DIR="/usr/share/sddm/themes/silent"

# ── Theme data ────────────────────────────────────────────────
declare -a FILES=(onepiece.conf luffy.conf shanks.conf sunny.conf default.conf nord.conf catppuccin-mocha.conf everforest.conf ken.conf silvia.conf rei.conf)
declare -a NAMES=(Zoro Luffy Shanks Sunny Default Nord Catppuccin Everforest Ken Silvia Rei)
declare -a DESCS=(
    "Gold & ocean blue, swordsman energy"
    "Gear 5 white & red, Sun God Nika"
    "Crimson & gold, Yonko elegance"
    "Bright yellow & blue, Thousand Sunny"
    "Smoky minimal dark theme"
    "Arctic blue minimal"
    "Mocha pastel dark"
    "Warm forest greens"
    "Red accent, right-aligned"
    "Black & white, left-aligned"
    "Anime blue tones"
)

COUNT=${#FILES[@]}
current=$(awk -F '=' '/^[^#]*ConfigFile=/ {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}' "$METADATA")

# Find current index
selected=1
for i in "${!FILES[@]}"; do
    if [ "$current" = "configs/${FILES[$i]}" ]; then
        selected=$((i + 1))
        break
    fi
done

# ── Cursor helpers ────────────────────────────────────────────
hide_cursor() { printf '\e[?25l'; }
show_cursor() { printf '\e[?25h'; }
move_home()   { printf '\e[H'; }
clear_screen(){ printf '\e[2J\e[H'; }

cleanup() { show_cursor; stty sane 2>/dev/null; echo; exit 0; }
trap cleanup EXIT INT TERM

# ── Draw ──────────────────────────────────────────────────────
draw() {
    clear_screen

    echo ""
    printf '  %s%s  SILENT SDDM THEME SELECTOR%s\n' "$yellow" "$bold" "$reset"
    printf '  %s  ──────────────────────────────%s\n' "$grey" "$reset"
    echo ""

    local section="op"
    for i in $(seq 0 $((COUNT - 1))); do
        local num=$((i + 1))

        if [ "$num" -eq 5 ]; then
            echo ""
            printf '  %s  OTHER THEMES%s\n' "$white" "$reset"
            echo ""
        fi

        # Active marker
        local marker=" "
        if [ "$current" = "configs/${FILES[$i]}" ]; then
            marker="${green}\xe2\x97\x8f${reset}"
        fi

        if [ "$num" -eq "$selected" ]; then
            # Highlighted row (reverse video)
            printf '  %b  \e[7m %2d  %-12s %s\e[27m\n' "$marker" "$num" "${NAMES[$i]}" "${DESCS[$i]}"
        else
            printf '  %b  %s%2d  %s%-12s%s %s%s%s\n' "$marker" "$grey" "$num" "$cyan" "${NAMES[$i]}" "$reset" "$dim" "${DESCS[$i]}" "$reset"
        fi
    done

    echo ""
    printf '  %s  ──────────────────────────────%s\n' "$grey" "$reset"
    printf '  %s  \xe2\x86\x91\xe2\x86\x93 navigate  Enter select  s install  q quit%s\n' "$grey" "$reset"
    echo ""
}

# ── Apply theme ───────────────────────────────────────────────
apply() {
    local idx=$((selected - 1))
    local file="${FILES[$idx]}"
    local name="${NAMES[$idx]}"

    sed -i "s|^[[:space:]]*ConfigFile=.*| ConfigFile=configs/${file}|" "$METADATA"
    current="configs/$file"

    draw
    echo ""
    printf '  %s%s \xe2\x9c\x93 Activated: %s%s (%s)%s\n' "$green" "$bold" "$white" "$name" "$file" "$reset"
    echo ""
    printf '  %sPress Enter to test, or any other key to stay...%s' "$dim" "$reset"

    stty raw -echo
    local key
    IFS= read -r -n1 key 2>/dev/null
    stty -raw echo

    if [ -z "$key" ]; then
        echo ""
        echo ""
        printf '  %sLaunching SDDM greeter... (close window to stop)%s\n\n' "$yellow" "$reset"
        QT_IM_MODULE=qtvirtualkeyboard QML2_IMPORT_PATH="$SCRIPT_DIR/components/" \
            sddm-greeter-qt6 --test-mode --theme "$SCRIPT_DIR" >/dev/null 2>&1
        printf '\n  %sTest ended.%s\n\n' "$green" "$reset"
    fi
}

# ── Sync to system ────────────────────────────────────────────
sync_to_system() {
    draw
    echo ""
    printf '  %s%s Install to system%s\n' "$yellow" "$bold" "$reset"
    echo ""
    printf '  %sThis will copy all files to:%s\n' "$grey" "$reset"
    printf '  %s%s%s\n\n' "$white" "$INSTALL_DIR" "$reset"
    echo -n "  Proceed? [y/N] "

    local key
    key=$(dd bs=1 count=1 2>/dev/null)
    echo ""

    if [ "$key" = "y" ] || [ "$key" = "Y" ]; then
        echo ""
        printf '  %sCopying...%s\n' "$yellow" "$reset"
        sudo cp -rf "$SCRIPT_DIR/." "$INSTALL_DIR/"
        echo ""

        if [ $? -eq 0 ]; then
            printf '  %s%s \xe2\x9c\x93 Installed successfully%s\n' "$green" "$bold" "$reset"
            echo ""
            printf '  %sChanges are live. Lock screen or re-login to see them.%s\n' "$grey" "$reset"
        else
            printf '  %s%s \xe2\x9c\x97 Install failed%s\n' "$red" "$bold" "$reset"
        fi
        echo ""
        echo -n "  Press any key to continue..."
        read -rsn1
    fi
}

# ── Read single key (handles arrows) ─────────────────────────
readkey() {
    local k
    IFS= read -rsn1 k 2>/dev/null

    case "$k" in
        '')  echo "ENTER" ;;
        $'\e')
            local s
            IFS= read -rsn2 -t 0.1 s 2>/dev/null
            case "$s" in
                '[A') echo "UP"    ;;
                '[B') echo "DOWN"  ;;
                '[C') echo "RIGHT" ;;
                '[D') echo "LEFT"  ;;
                *)    echo "ESC"   ;;
            esac
            ;;
        *) echo "$k" ;;
    esac
}

# ── Main ──────────────────────────────────────────────────────
hide_cursor
draw

while true; do
    k=$(readkey)

    case "$k" in
        UP|k|K)    selected=$(( selected <= 1 ? COUNT : selected - 1 )); draw ;;
        DOWN|j|J)  selected=$(( selected >= COUNT ? 1 : selected + 1 )); draw ;;
        LEFT)      selected=1;  draw ;;
        RIGHT)     selected=5;  draw ;;
        ENTER)     apply; draw ;;
        s|S)       sync_to_system; draw ;;
        q|Q)       cleanup ;;
    esac
done
