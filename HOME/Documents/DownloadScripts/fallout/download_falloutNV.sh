#!/usr/bin/env bash

# Instellingen
URL="https://fallout.wiki/wiki/Vault_Boy/Fallout:_New_Vegas"
OUTPUT_DIR="$HOME/Downloads/fallout/FalloutNV"
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36"

# Maak de downloadmap aan als deze nog niet bestaat
mkdir -p "$OUTPUT_DIR"

echo "Bezig met ophalen van galerij pagina: $URL"

# Haal de hoofdpagina op
MAIN_PAGE=$(curl -s -H "User-Agent: $USER_AGENT" "$URL")

if [ -z "$MAIN_PAGE" ]; then
    echo "[Fout] Kon de hoofdpagina niet ophalen."
    exit 1
fi

# Vind alle /wiki/File: links op de pagina
LINKS=$(echo "$MAIN_PAGE" | grep -o '/wiki/File:[^"]*' | sort -u)

if [ -z "$LINKS" ]; then
    echo "[Fout] Kon geen galerij links vinden op de pagina."
    exit 1
fi

DOWNLOAD_COUNT=0
declare -A SEEN_URLS

for link in $LINKS; do
    FILE_PAGE_URL="https://fallout.wiki${link}"
    echo -n "Analyseer item... "

    # Kleine pauze om de server te ontzien
    sleep 0.3

    # Haal de afbeeldingspagina op
    FILE_PAGE=$(curl -s -H "User-Agent: $USER_AGENT" "$FILE_PAGE_URL")

    if [ -z "$FILE_PAGE" ]; then
        echo -e "\n[Waarschuwing] Kon de pagina niet ophalen: $FILE_PAGE_URL"
        continue
    fi

    # Zoek naar de full-res afbeelding link (fullImageLink of id="file")
    IMG_HREF=$(echo "$FILE_PAGE" | grep -oP 'class="fullImageLink".*?<a href="\K[^"]+' | head -n 1)
    
    if [ -z "$IMG_HREF" ]; then
        IMG_HREF=$(echo "$FILE_PAGE" | grep -oP 'id="file".*?<a href="\K[^"]+' | head -n 1)
    fi

    if [ -z "$IMG_HREF" ]; then
        echo -e "\n[Waarschuwing] Kon geen directe downloadlink vinden op $FILE_PAGE_URL"
        continue
    fi

    # Maak de afbeelding URL absoluut
    if [[ "$IMG_HREF" =~ ^http ]]; then
        IMG_URL="$IMG_HREF"
    else
        IMG_URL="https://fallout.wiki${IMG_HREF}"
    fi

    # Controleer op duplicaten
    if [ -n "${SEEN_URLS[$IMG_URL]}" ]; then
        continue
    fi
    SEEN_URLS[$IMG_URL]=1

    # Bepaal bestandsnaam
    FILENAME=$(basename "${IMG_URL%%\?*}")
    if [ -z "$FILENAME" ]; then
        FILENAME="image_${DOWNLOAD_COUNT}.png"
    fi

    FILEPATH="$OUTPUT_DIR/$FILENAME"

    # Download het bestand
    curl -s -H "User-Agent: $USER_AGENT" "$IMG_URL" -o "$FILEPATH"

    if [ $? -eq 0 ]; then
        echo -e "\n[Gedownload (Full-res)] $FILENAME"
        ((DOWNLOAD_COUNT++))
    else
        echo -e "\n[Fout] Download mislukt voor $IMG_URL"
    fi
done

echo -e "\nKlaar! $DOWNLOAD_COUNT unieke full-res afbeeldingen opgeslagen in '$OUTPUT_DIR'."
