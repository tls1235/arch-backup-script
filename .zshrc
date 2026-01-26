# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

HISTSIZE=10000
SAVEHIST=10000
ZSH_AUTOSUGGEST_STRATEGY=completion
setopt appendhistory
setopt sharehistory
setopt nobeep
setopt interactivecomments
setopt AUTO_LIST
setopt AUTO_MENU
setopt ALWAYS_TO_END
unsetopt COMPLETE_IN_WORD
unsetopt CORRECT
unsetopt CORRECT_ALL
bindkey -e
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'
alias ll='ls -ah'
alias nix-gc='nix-collect-garbage -d'
source .functions.sh
export NIXPKGS_ALLOW_UNFREE=1
