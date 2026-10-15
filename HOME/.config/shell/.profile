## ─────────╮
## .PROFILE │
## ─────────┴──────────────────────────────────────────────────────────────────────────────────────
##
## Table of Contents


## XDG-Configuration
## Languages
## Libraries
## Regular-Environment
## EZA-Colors
## Paths
## Little-Stuff

## ────────────────────────────────────────────────────────────────────────────────────────────────
## XDG-Configuration

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_RUNTIME_DIR="/run/user/1000"
export XDG_LANGUAGES="$HOME/.languages"


## ────────────────────────────────────────────────────────────────────────────────────────────────
## Languages

export CARGO_HOME="$HOME/.languages/rust/cargo"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_GLOBAL_HOME="$XDG_DATA_HOME/npm"
export RUSTUP_HOME="$HOME/.languages/rust/rustup"
. "$HOME/.languages/rust/cargo/env"


## ────────────────────────────────────────────────────────────────────────────────────────────────
## Libraries

# export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
# export LIBRARY_PATH=/usr/local/lib:$LIBRARY_PATH
# export LD_LIBRARY_PATH="/usr/local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"


## ────────────────────────────────────────────────────────────────────────────────────────────────
## Regular-Environment

# export BROWSER="/usr/bin/librewolf"                          # Browser
export BROWSER="/bin/garcon-url-handler"
export EDITOR='nvim'                                         # Terminal editor
export DISPLAY="${DISPLAY:-:0}"
export GNUPGHOME="$HOME/.config/gnupg"                       # GNUPG
export MANPAGER='nvim +Man!'                                 # Terminal Manpager
export PASSWORD_STORE_DIR="$HOME/.config/password-store"     # Passwords
export SCRIPTS="$HOME/scripts"                               # Personal scripts
export TZ="Europe/Amsterdam"                                 # Local timezone
export XCURSOR_THEME="Bibata-Modern-Ice"                     # Linux theme

export DENO_INSTALL="/home/itsamus/.deno"                    # Path for dno (used for yt-dlp)
export FIGLET_FONTDIR="$XDG_CONFIG_HOME/figlet"              # Directory for figlets.
export HISTFILE="$XDG_CACHE_HOME/bash_history"               # Shell history file.
export LESSHISTFILE=-                                        # Less history file.
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc" # Path for ripgrep.
export WGETRC=$HOME/.config/wget/wgetrc                      # Path for the wget file.
export TLDR_CONFIG_DIR="$XDG_CONFIG_HOME/tldr"
export LYNX_CFG="$XDG_CONFIG_HOME/lynx/lynx.cfg"


## ────────────────────────────────────────────────────────────────────────────────────────────────
## EZA-Colors
export BOXES="$XDG_CONFIG_HOME/boxes/boxes"
export EZA_COLORS="di=3;38;5;21:ex=38;5;46:fi=38;5;250:ln=3;38;5;165:or=1;38;5;16;48;5;197:ur=38;5;240:uw=38;5;250:ux=38;5;196:ue=38;5;196:gr=38;5;240:gw=38;5;250:gx=38;5;196:tr=38;5;240:tw=38;5;250:tx=38;5;196:lp=38;5;201:*.py=38;2;255;188;45:*.lua=38;2;81;175;239:*.js=38;2;247;223;30:*.ts=38;2;49;120;198:*.rs=38;2;222;165;132:*.go=38;2;0;173;216:*.c=38;2;168;185;204:*.cpp=38;2;168;185;204:*.cc=38;2;168;185;204:*.cxx=38;2;168;185;204:*.java=38;2;237;139;0:*.php=38;2;119;123;180:*.rb=38;2;204;52;45:*.swift=38;2;240;81;56:*.kt=38;2;127;82;255:*.kts=38;2;127;82;255:*.dart=38;2;1;117;194:*.ex=38;2;78;42;142:*.exs=38;2;78;42;142:*.hs=38;2;94;80;134:*.html=38;2;227;79;38:*.htm=38;2;227;79;38:*.css=38;2;21;114;182:*.scss=38;2;204;102;153:*.sass=38;2;204;102;153:*.jsx=38;2;97;218;251:*.tsx=38;2;49;120;198:*.vue=38;2;79;192;141:*.svelte=38;2;255;62;0:*.astro=38;2;255;93;1:*.json=38;2;251;192;45:*.yaml=38;2;203;23;30:*.yml=38;2;203;23;30:*.toml=38;2;156;156;156:*.xml=38;2;227;121;51:*.md=38;2;0;131;209:*.txt=38;2;176;190;197:*.sql=38;2;68;121;161:*.sh=38;2;78;154;6:*.bash=38;2;78;154;6:*.nvim=38;2;80;160;64:*rc=38;2;149;91;227"

export NEWT_COLORS="
    actbutton=black,brightred
    actcheckbox=black,brightred
    actlistbox=black,brightred
    actmenu=white,white
    actsellistbox=black,brightred
    acttextbox=white,white
    border=brightred,black
    button=black,brightred
    checkbox=brightred,black
    compactbutton=brightred,black
    disabledentry=white,white
    disentry=white,white
    emptyscale=white,white
    entry=brightred,black
    fullscale=white,white
    helpline=white,white
    label=white,white
    listbox=brightred,black
    menu=white,white
    root=brightred,black
    roottext=white,white
    sellistbox=white,white
    shadow=black,black
    textbox=brightred,black
    title=black,brightred
    window=black,black
    "

## ────────────────────────────────────────────────────────────────────────────────────────────────
## Paths
# PATHS_TO_ADD=(
#   "/bin"
#   "/usr/bin"
#   "/usr/local/bin"
#   "$HOME/.local/bin"
#   "$CARGO_HOME/bin"
#   "$HOME/EX-programs/lib"
# )
# NEW_PATH=""
# for dir in "${PATHS_TO_ADD[@]}"; do
#   [[ -d "$dir" ]] && NEW_PATH="${NEW_PATH:+$NEW_PATH:}$dir"
# done
# export PATH="$NEW_PATH:$PATH"

PATHS_TO_ADD=(
  "/opt/nvim/bin"
  "$HOME/.local/share/gem/ruby/3.3.0/bin"
  "/bin"
  "/usr/bin"
  "/usr/local/bin"
  "$HOME/.local/bin"
  "$CARGO_HOME/bin"
  "$HOME/EX-programs/lib"
)

NEW_PATH=""
for dir in "${PATHS_TO_ADD[@]}"; do
  [[ -d "$dir" ]] && NEW_PATH="${NEW_PATH:+$NEW_PATH:}$dir"
done

# Gebruik alleen de opgebouwde lijst (eventueel met de rest van het oude pad erachter als je dat per se wilt)
export PATH="$NEW_PATH"


## ────────────────────────────────────────────────────────────────────────────────────────────────
## Little-Stuff
source $HOME/.config/shell/bash/.bashrc
. "/home/itsamus/.languages/rust/cargo/env"


## ────────────────────────────────────────────────────────────────────────────────────────────────
# export ABOOK_DIR="$HOME/.config/abook"
# export VAULT_DIR="$HOME/wiki"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export SIMPLELOGIN_API_KEY=""
export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg
