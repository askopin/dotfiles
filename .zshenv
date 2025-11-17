if [[ -z "$XDG_CONFIG_HOME" ]]
then
        export XDG_CONFIG_HOME="$HOME/.config/"
fi

export PATH=$PATH:$HOME/.local/bin
export PATH=/opt/homebrew/bin:$PATH

jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}

# get gzipped size
gzp() {
  echo "orig size    (bytes): "
  wc -c "$1"
  echo "gzipped size (bytes): "
  gzip -c "$1" | wc -c
}

# Create a new directory and enter it
mcd() {
  mkdir -p "$@" && cd "$_"
}

# Jump to folder (zoxide) and open nvim.
zv() {
 z "$1" && nvim .
}

# Go to repository root folder
groot() {
  root="$(git rev-parse --show-toplevel 2>/dev/null)"
  if [ -n "$root" ]; then
    cd "$root";
  else
    echo "Not in a git repository"
  fi
}

# Compare json files
jsondiff() {
  delta <(jq --sort-keys . $1) <(jq --sort-keys . $2)
}

brewit() {
  brew update &&
    brew upgrade &&
    brew autoremove &&
    brew cleanup -s &&
    brew doctor
}

y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

enable-proxy() {
  networksetup -setwebproxy Wi-Fi localhost 9000
  networksetup -setsecurewebproxy Wi-Fi localhost 9000
  networksetup -setwebproxystate Wi-Fi on
  networksetup -setsecurewebproxystate Wi-Fi on
}

disable-proxy() {
  networksetup -setwebproxystate Wi-Fi off
  networksetup -setsecurewebproxystate Wi-Fi off
}


copy_no_newline() {
  "$@" | tr -d '\n' | pbcopy
}

## mise
eval "$($(brew --prefix)/bin/mise activate zsh)"

# Lock the screen (when going AFK)
alias afk="osascript -e 'tell app \"System Events\" to key code 12 using {control down, command down}'"

## Command shortcuts

#alias ip="ifconfig -a | egrep -A 8 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"

