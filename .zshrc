source ~/.aliases

# Change terminal navigation style to vim from emacs.
set -o vi

function set_win_title(){
    echo -ne "\033]0; ${HOST}: $PWD \007"
}
precmd_functions+=(set_win_title)
