#!/usr/bin/env -S bash

source $XDG_CONFIG_HOME/yt-dlp/.venv/bin/activate

# Controleer of whiptail is geïnstalleerd
if ! command -v whiptail &> /dev/null; then
    echo "Fout: whiptail is niet geïnstalleerd."
    exit 1
fi

# 1. Menu voor Playlist instelling
PLAYLIST_CHOICE=$(whiptail --title "YT-DLP - Playlist Optie" --menu "Wil je hele playlists downloaden of alleen losse video's?" 15 60 2 \
    "1" "Alleen losse video downloaden (--no-playlist)" \
    "2" "Hele playlist downloaden (--yes-playlist)" 3>&1 1>&2 2>&3)

if [ $? -ne 0 ]; then
    echo "Geannuleerd."
    exit 0
fi

case $PLAYLIST_CHOICE in
    1) PL_ARG="--no-playlist" ;;
    2) PL_ARG="--yes-playlist" ;;
esac

# 2. Inputbox voor de downloadmap
DOWNLOAD_PATH=$(whiptail --title "YT-DLP - Download Pad" --inputbox "Voer het pad in waar de bestanden opgeslagen moeten worden:" 10 60 "$HOME/Music" 3>&1 1>&2 2>&3)

if [ $? -ne 0 ]; then
    echo "Geannuleerd."
    exit 0
fi

# 3. Inputbox voor de download URL
VIDEO_URL=$(whiptail --title "YT-DLP - Download URL" --inputbox "Voer de YouTube (of media) URL in:" 10 60 "" 3>&1 1>&2 2>&3)

if [ $? -ne 0 ] || [ -z "$VIDEO_URL" ]; then
    echo "Geannuleerd of geen URL ingevoerd."
    exit 0
fi

# Voer yt-dlp uit met de gekozen opties, pad en de ingevoerde URL
yt-dlp $PL_ARG -P "$DOWNLOAD_PATH" "$VIDEO_URL" "$@"

echo -e "\n \n this was executed with an alias that ran a script \n"
