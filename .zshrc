alias config='/usr/bin/git --git-dir=/Users/vladilie/.cfg/ --work-tree=/Users/vladilie'
# alias ls='[ $(pwd) = $HOME ] && gls -IDocuments -IPictures -IMovies -ILibrary -IApplications -ILibrary -IMusic -IPublic || \ls'
alias vim=nvim
alias comp=docker-compose
alias grep='grep --color'

bindkey -e

for f in $HOME/.config/personal/*; do
    source "$f"
done

# fg-bg toggle via c-z
function fg-bg {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER=fg
        zle accept-line
    else
        zle push-input
    fi
}
zle -N fg-bg
bindkey '^z' fg-bg

# chruby
eval "$(direnv hook zsh)"
source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh
source $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh

# go
export PATH="/Users/vladilie/.goenv/shims:${PATH}"
eval "$(goenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# prompt
autoload -U colors && colors
setopt PROMPT_SUBST

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

# display exitcode on the right when >0
return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

RPROMPT='${return_code}$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

PROMPT='[ %{$fg[red]%}%n%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info) ]
%# '

export CLICOLOR=1

# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# autocomplete
export fpath=("$HOME/.config/completions/" $fpath)
autoload -U compinit; compinit

# open last directory
scd() {
    if [[ -d "$PWD/$1" ]]; then
        echo "$PWD/$1" > "$HOME/.config/.last_folder_visited"
    fi
    \cd "$1"
}
alias cd=scd

if [[ -e "$HOME/.config/.last_folder_visited" ]]; then
    cd "$(cat "$HOME/.config/.last_folder_visited")"
fi

# Created by `pipx` on 2024-12-17 09:11:02
export PATH="$PATH:/Users/vladilie/.local/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/vladilie/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/vladilie/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/vladilie/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/vladilie/google-cloud-sdk/completion.zsh.inc'; fi
