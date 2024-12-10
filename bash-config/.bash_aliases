. /etc/os-release

if [ "$NAME" = "Ubuntu" ]; then
	alias cat='batcat'
else
	alias cat='bat'
fi

alias ls='eza'
alias open='explorer.exe'
alias vim='nvim'
alias gpsh='git push origin'
alias gpll='git pull origin'
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias ll='eza -alF'
alias la='eza -A'
alias l='eza -CF'
alias lg='lazygit'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

