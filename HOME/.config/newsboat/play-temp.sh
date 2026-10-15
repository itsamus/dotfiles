#!/usr/bin/env bash
URL="$1"

# Maak een tijdelijk bestand aan voor de video
TEMP_FILE=$(mktemp --suffix=.mp4)

# Download de video direct naar het tijdelijke bestand met yt-dlp
source $HOME/.config/yt-dlp/.venv/bin/activate
yt-dlp -o "$TEMP_FILE" "$URL"

# Als de download slaagt, speel hem af met mpv
if [ -f "$TEMP_FILE" ]; then
    mpv "$TEMP_FILE"
    # Verwijder het bestand direct nadat mpv is afgesloten
    rm -f "$TEMP_FILE"
fi
