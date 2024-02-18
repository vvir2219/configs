autoload -U compinit; compinit

alias config='/usr/bin/git --git-dir=/Users/vladilie/.cfg/ --work-tree=/Users/vladilie'
# alias ls='[ $(pwd) = $HOME ] && gls -IDocuments -IPictures -IMovies -ILibrary -IApplications -ILibrary -IMusic -IPublic || \ls'
alias vim=nvim

bindkey -e

eval "$(direnv hook zsh)"
source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh
source $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh

for f in $HOME/.config/personal/*; do
    source "$f"
done

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

PROMPT='[%{$fg[red]%}%n%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)]
%# '
