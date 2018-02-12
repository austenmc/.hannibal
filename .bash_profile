export EDITOR=vim
export SANDBOX=

export PATH="/usr/local/sbin:$PATH"
export PATH="~/bin:$PATH"

source ~/.aliases

# Change terminal navigation style to vim from emacs.
set -o vi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Better history management, see http://briancarper.net/blog/248.html
shopt -s histappend
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
