# Colores
_GREEN="%{$fg[green]%}"
_YELLOW="%{$fg[yellow]%}"
_BLUE="%{$fg[blue]%}"
_RESET="%{$reset_color%}"

# Git: branch en amarillo/naranja si hay cambios, verde si está limpio
ZSH_THEME_GIT_PROMPT_PREFIX=" ${_GREEN} "
ZSH_THEME_GIT_PROMPT_SUFFIX="${_RESET}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}${_RESET}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Prompt
PROMPT="${_BLUE}%~${_RESET}"
PROMPT+='$(git_prompt_info)'
  PROMPT+="${_BLUE} ${_RESET}"
