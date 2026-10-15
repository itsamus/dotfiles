liniaal() {
    local input
    if [ -n "$1" ]; then
        input=$(cat "$@")
    elif [ ! -t 0 ]; then
        input=$(cat)
    else
        echo "Geen invoer meegegeven."
        return
    fi

    # Bepaal de lengte van de langste regel in de invoer
    local breedte
    breedte=$(echo "$input" | awk '{ if (length($0) > max) max = length($0) } END { print max }')

    # Als de invoer leeg is, stop direct
    [ -z "$breedte" ] || [ "$breedte" -eq 0 ] && breedte=10

    # Functie om de volledige liniaal-blok te printen
    print_volledige_liniaal() {
        # 1. Print de indexnummers exact boven de '|' kolommen
        local huidige_pos=0
        for ((i=10; i<=breedte; i+=10)); do
            local getal=$((i/10))
            local getal_lengte=${#getal}

            # Bereken exact hoeveel ruimte we nodig hebben tot aan de juiste kolom
            local aantal_spaties=$((i - huidige_pos - getal_lengte))

            printf "%${aantal_spaties}s%d" "" "$getal"
            huidige_pos=$i
        done
        echo ""

        # 2. Print de "|" regel met een donkergrijze achtergrond
        printf "\e[48;5;236m"
        for ((i=1; i<=breedte; i++)); do
            if [ $((i % 10)) -eq 0 ]; then
                printf "|"
            else
                printf " "
            fi
        done
        printf "\e[0m\n"
    }

    # Print de eerste liniaal aan het begin
    print_volledige_liniaal

    # Print de daadwerkelijke invoer en herhaal de volledige liniaal om de 50 regels
    local teller=0
    echo "$input" | while IFS= read -r regel; do
        echo "$regel"
        ((teller++))
        if [ $((teller % 50)) -eq 0 ]; then
            print_volledige_liniaal
        fi
    done
}
