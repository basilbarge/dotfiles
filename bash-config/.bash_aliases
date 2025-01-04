. /etc/os-release

if [ "$NAME" = "Ubuntu" ]; then
	alias cat='batcat'
else
	alias cat='bat'
fi

alias ls='eza --icons=always' 
alias open='explorer.exe'
alias vim='nvim'
alias gpsh='git push origin'
alias gpll='git pull origin'
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias ll='eza -alF --icons=always'
alias la='eza -A'
alias l='eza -CF'
alias lg='lazygit'
