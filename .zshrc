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

#source ~/.hannibal/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"

worktree() {
  local create_branch=false

  if [ "$1" = "-b" ]; then
    create_branch=true
    shift
  fi

  if [ -z "$1" ]; then
    echo "Usage: worktree [-b] <branch-name>"
    return 1
  fi

  local branch="$1"
  local folder=$(basename "$PWD")
  local clean_branch=$(echo "$branch" | sed 's/[\/\\:]/-/g')
  local target="../${folder}-${clean_branch}"
  local original_dir="$PWD"

  git fetch

  if [ "$create_branch" = true ]; then
    git worktree add -b "$branch" "$target"
  else
    git worktree add "$target" "$branch"
  fi
  cd "$target"

  # Copy .env file from original directory if it exists
  if [ -f "$original_dir/.env" ]; then
    cp "$original_dir/.env" .env
  fi

  # Install dependencies if package.json exists
  if [ -f "package.json" ]; then
    if [ -f "yarn.lock" ]; then
      yarn install
    else
      npm install
    fi
  fi
}
