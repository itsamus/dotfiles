df_logic() {
    printf "CHOOSE\n [[Enter]] = df -h \\ \n [[.]]     = du -sh .\n> "
    read -r k
    [[ "$k" == "." ]] && du -sh && echo -e "\nThis command was run as an alias and invoked a custom function" && return
    [[ -z "$k" ]] && command df -h / && echo -e "\nThis command was run as an alias and invoked a custom function" && return
    echo "Invalid choice"
}
