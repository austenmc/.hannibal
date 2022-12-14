export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS

source ~/.hannibal/.aliases
source ~/.aliases

# Change terminal navigation style to vim from emacs.
set -o vi

function set_win_title(){
    echo -ne "\033]0; ${HOST}: $PWD \007"
}
precmd_functions+=(set_win_title)

source ~/.hannibal/zsh-autosuggestions/zsh-autosuggestions.zsh
