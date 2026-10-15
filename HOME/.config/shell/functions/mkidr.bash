mkdir() {
    command mkdir -p "$@" && cd "${@: -1}"
}
