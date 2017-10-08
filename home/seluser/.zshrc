###############################################################
# oh-my-zsh
###############################################################
export DISABLE_AUTO_UPDATE=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(docker docker-compose)
source $ZSH/oh-my-zsh.sh
source /usr/share/powerline/bindings/zsh/powerline.zsh

###############################################################
# User configuration
###############################################################

# --- force tmux 256 colors
alias tmux="tmux -2"

# --- Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;33;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[00;32;5;146m' # begin underline

# --- open screen/tmux or reattach
# if [[ $STY = '' ]]; then screen -xR $USER; fi
# if [[ $TMUX = "" ]]; then tmux attach -t $USER || tmux new -s $USER; fi
