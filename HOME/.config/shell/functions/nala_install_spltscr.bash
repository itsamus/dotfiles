nala() {
        local action="$1"

        if [ "$action" = "install" ]; then
                shift # Pas verschuiven als het om install gaat
                kitten @ launch --location=hsplit --bias 30 --keep-focus bash -c "sudo nala install -y $* ; exit"
        else
                # Gebruik gewoon "$@" zodat de actie (bijv. purge) én de argumenten behouden blijven
                command sudo nala "$@"
        fi
}
