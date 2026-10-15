## ┌────────────────────┐
## │ Bash Configuration │
## └────────────────────┘
## Prompt ======================================================================
## Load the customized shell prompt
[[ -e "$XDG_CONFIG_HOME/shell/bash/crosh-prompt.bash" ]] && . "$XDG_CONFIG_HOME/shell/bash/crosh-prompt.bash"
## Prompt command
PROMPT_COMMAND="history -a; history -n; __zoxide_hook"

## Interactive shell ===========================================================
case $- in
    *i*) ;;
    *) return ;;
esac

## Aliases ====================================================================
## Shell specific aliases
alias \
    sbash="source $XDG_CONFIG_HOME/shell/bash/.bashrc" \
    nbash="nvim $XDG_CONFIG_HOME/shell/bash/.bashrc"
## Load personal alias file
source $HOME/.config/aliasrc

## History =====================================================================
HISTSIZE=10000                                  # The number of lines to keep in memory for the current session.
HISTFILESIZE=20000                              # The maximum number of lines contained in the history file.
HISTFILE="$XDG_CACHE_HOME/bash_history"         # Location of the shell history file.
HISTIGNORE="ls:lsa:lsaa:pwd:cd:c:clear:history" # Commands to ignore in the history file.
HISTCONTROL=ignoreboth:erasedups                # Ignore and remove duplicate history commands in the history file.
# HISTTIMEFORMAT="$(echo -e '\e[32m%d-%m  \e[0m')"    # Display the date by the commands in the history file. (Green dd-mm format)
HISTTIMEFORMAT=$'\e[32m%d-%m  \e[0m'

## Built-in Commands ===========================================================
## No need to write "cd" to move to a dirictory.
shopt -s autocd
## When using "cd", autocorrect spelling mistakes.
shopt -s cdspell
## Bash checks the window size after each external (non-builtin) command
## and, if necessary, updates the values of LINES and COLUMNS.
shopt -s checkwinsize
## Yet another option for checking spelling mistakes for directories.
shopt -s dirspell
## Enable path name expansion.
shopt -s extglob
## Append to the Bash history file, rather than overwriting it.
shopt -s histappend
## Print history commands first to the readline (prompt) before executing it.
shopt -s histverify
## multi-line commands are saved to the history with embedded newlines rather than
## using semicolon separators where possible. ( In combination with cmdhist. ENABLED by DEFAULT )
shopt -s lithist
## Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
## Personal Keybindings ========================================================
## -- Unbindings ===============================================================
stty -ixon     # Disable 'Software Flow Control' (CTRL + S/Q)
bind -r '\C-f' # Disable forward-char
bind -r '\C-n' # Disable next-history

## -- Bindings =================================================================
bind -x '"\C-h": interactive_shell_history'
bind -x '"\C-n": open_notes'
## Custom Functions ============================================================
## Load customized functions for the shell.
for file in "$XDG_CONFIG_HOME"/shell/functions/*; do
    [[ -x "$file" ]] && source "$file"
done

## Little Stuff ================================================================
## Load zoxide. This is a handy program to change directories.
eval "$(zoxide init bash)"
## Speed up the input rate of the keyboard
xset r rate 300 50

eval "$(luarocks path --local)"

# if [ "$TERM" = "xterm-kitty" ]; then
#     # RANDOM_PIC=$(find /home/itsamus/downloads/photos/fallout/color -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n 1)
#     RANDOM_PIC=$(find /home/itsamus/POKEDEX -type f -name "*1080*.png" | shuf -n 1)
#     if [ -n "$RANDOM_PIC" ]; then
#         kitty @ set-background-image "$RANDOM_PIC"
#     fi
# fi

export GH_TOKEN="$(pass github/token)" # Github
# export CROC_SECRET="$(pass croc/secret)"
source $HOME/.config/pet/pet_completion

function pet-select() {
    BUFFER=$(pet search --query "$READLINE_LINE")
    READLINE_LINE=$BUFFER
    READLINE_POINT=${#BUFFER}
}
bind -x '"\C-x\C-r": pet-select'

function _pet_move_cursor_to_next_parameter() {
    match="$(echo "$READLINE_LINE" | perl -nle 'print $& if /<.*?>/')"
    if [ -n "$match" ]; then
        default="$(echo "$match" | sed 's/<//g' | sed 's/>//g' | cut -d'=' -f2)"
        match_len=${#match}
            default_len=${#default}
                pre_match=${READLINE_LINE%%$match*}
                parameter_offset=${#pre_match}
                    READLINE_POINT="$((${parameter_offset} + ${default_len}))"
                    READLINE_LINE="${READLINE_LINE:0:$parameter_offset}${default}${READLINE_LINE:$parameter_offset+$match_len}"
    fi
}
# bind -x '"\C-n": _pet_move_cursor_to_next_parameter'
#
# # ~/.bashrc: executed by bash(1) for non-login shells.
# # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# # for examples
#
# # If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#       *) return;;
# esac
#
# # don't put duplicate lines or lines starting with space in the history.
# # See bash(1) for more options
# HISTCONTROL=ignoreboth
#
# # append to the history file, don't overwrite it
# shopt -s histappend
#
# # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000
#
# # check the window size after each command and, if necessary,
# # update the values of LINES and COLUMNS.
# shopt -s checkwinsize
#
# # If set, the pattern "**" used in a pathname expansion context will
# # match all files and zero or more directories and subdirectories.
# #shopt -s globstar
#
# # make less more friendly for non-text input files, see lesspipe(1)
# #[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
#
# # set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi
#
# # set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
#     xterm-color|*-256color) color_prompt=yes;;
# esac
#
# # uncomment for a colored prompt, if the terminal has the capability; turned
# # off by default to not distract the user: the focus in a terminal window
# # should be on the output of commands, not on the prompt
# #force_color_prompt=yes
#
# if [ -n "$force_color_prompt" ]; then
#     if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#         # We have color support; assume it's compliant with Ecma-48
#         # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#         # a case would tend to support setf rather than setaf.)
#         color_prompt=yes
#     else
#         color_prompt=
#     fi
# fi
#
# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt
#
# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac
#
# # enable color support of ls and also add handy aliases
# if [ -x /usr/bin/dircolors ]; then
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#     alias ls='ls --color=auto'
#     #alias dir='dir --color=auto'
#     #alias vdir='vdir --color=auto'
#
#     #alias grep='grep --color=auto'
#     #alias fgrep='fgrep --color=auto'
#     #alias egrep='egrep --color=auto'
# fi
#
# # colored GCC warnings and errors
# #export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#
# # some more ls aliases
# #alias ll='ls -l'
# #alias la='ls -A'
# #alias l='ls -CF'
#
# # Alias definitions.
# # You may want to put all your additions into a separate file like
# # ~/.bash_aliases, instead of adding them here directly.
# # See /usr/share/doc/bash-doc/examples in the bash-doc package.
#
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi
#
# # enable programmable completion features (you don't need to enable
# # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# # sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
eval "$(fnm env --use-on-cd)"

# In ~/.bashrc
files=(/home/itsamus/Downloads/fallout/*/*.png)
if [[ -e "${files[0]}" ]]; then
    ln -sf "${files[0]}" ~/.config/kitty/current_fallout.png
fi

