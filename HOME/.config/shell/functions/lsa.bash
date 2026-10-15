lsa() {
    local hide_dotfiles=""
    [[ "$PWD" == "$HOME" ]] && hide_dotfiles="--ignore-glob=.config|.local|.cache|.languages|.deno"

    LC_COLLATE=C \
    eza \
    -Al \
    --no-user \
    --no-time \
    --no-filesize \
    --color=always \
    --icons=always \
    --follow-symlinks \
    --group-directories-last \
    $hide_dotfiles
}
