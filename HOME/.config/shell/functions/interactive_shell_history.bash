interactive_shell_history() {
    local cmd
    # We halen de geschiedenis op, filteren met fzf, en gebruiken awk.
    # awk slaat het regelnummer ($1) en de datum ($2) over en print de rest ($3 en verder).
    cmd=$(history | fzf --cycle --tac --ansi | awk '{$1=""; $2=""; sub(/^[ \t]+/, ""); print}')

    if [ -n "$cmd" ]; then
        bind '"\e[0n": "'"$cmd"'"'
        printf '\e[5n'
    fi
}
