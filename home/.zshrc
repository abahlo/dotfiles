EDITOR=vim

# ZSH config
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="arne"
COMPLETION_WAITING_DOTS="true"

# Load all .zsh-Files in the zsh directory
for config_file in  $HOME/.dotfiles/zsh/**/*.zsh; do
  source $config_file
done

antigen use oh-my-zsh
antigen bundle rimraf/k
antigen theme bahlo/dotfiles zsh/arne

# Embed custom per-machine config
[[ -f ~/.localrc ]] && source ~/.localrc

antigen apply
