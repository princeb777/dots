# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# Allow autocomplete after sudo
complete -cf sudo

# Case-insensitive autocomplete
bind "set completion-ignore-case on"

# Handy shell options
shopt -s cdspell       # auto-correct minor typos in directory names
shopt -s autocd        # just type directory name to cd into it
shopt -s checkwinsize  # auto-update terminal size
bind "set show-all-if-ambiguous on"

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Colorful prompt: user@host:current_dir$
PS1="\[\e[1;32m\]\u@\h \[\e[1;34m\]\w\[\e[0m\]$ "

# Cargo environment
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
alias bt="bluetuith"

export PATH=$PATH:/home/meow/.spicetify
export PATH="$HOME/.local/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        cd "$(cat "$tmp")"
        rm -f "$tmp"
    fi
}

# --- Android SDK ---
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/36.0.0"
export PATH="$HOME/.cargo/bin:$PATH"
