
# Shell config
export LANG=en_US.UTF-8

## editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='code -w'
fi

# oh-my-zsh related stuff
export ZSH="$HOME/.oh-my-zsh"

plugins=(         
    git
    git-open
    encode64
    extract
    thefuck
    zsh-autosuggestions
    mise
)
source $ZSH/oh-my-zsh.sh

# prompt setup
eval "$(oh-my-posh init zsh --config ${HOME}/.oh-my-posh-theme.json)"


# zoxide init and override cd with it
# disabled due to claude issue
# eval "$(zoxide init zsh --cmd cd)"

## fzf
source <(fzf --zsh)

eval $(thefuck --alias)

# Aliases
## Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

## Adding always used keys to common calls
alias cp='cp -r'
alias rm='rm -r'
alias scp='scp -r'
alias grep='grep --color'


alias e="nvim"
alias c="clear"
alias lg="lazygit"


## Workflow
alias cleardd="rm -fr $HOME/Library/Developer/Xcode/DerivedData/*"
alias bepiru='bundle exec pod install --repo-update'
alias py='python'
alias gremote='git config --get remote.origin.url'
alias grcopy='copy_no_newline git config --get remote.origin.url'
alias gbcopy='copy_no_newline git rev-parse --abbrev-ref HEAD'
alias cpuuid='copy_no_newline uuidgen'

alias path='echo; tr ":" "\n" <<< "$PATH"; echo;'

## ZSH config
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"