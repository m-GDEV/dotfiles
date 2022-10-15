#      __               __             
#     / /_  ____ ______/ /_  __________
#    / __ \/ __ `/ ___/ __ \/ ___/ ___/
# _ / /_/ / /_/ (__  ) / / / /  / /__  
#(_)_.___/\__,_/____/_/ /_/_/   \___/
#
# By:            | Musa Ahmed
# Created On:    | July 3rd, 2021
# Last Modified: | Constantly


# THINGS THAT WERE ALRREADY HERE AND ARE NECESSARY (i think...)
# -------------------------------------------------------------

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

use_color=true

complete -cf sudo

HISTSIZE=15000
HISTFILESIZE=15000

shopt -s checkwinsize # checks term size when bash regains control
shopt -s expand_aliases # expand aliases so they can use arguments i think
shopt -s histappend # Enable history appending instead of overwriting.  #139609
shopt -s cdspell # ignore cd mispellings

bind "set completion-ignore-case on"


# ALIASES 
# -------------------------------------------------------------

# COMMON UTILITIES
alias ch='cd ~;clear'
alias cd='z' # to use z program that replaces cd
alias lf='exa -lah'
alias ll='exa -lh'
alias la='exa -a | grep "^\."' # only shows hidden files in dir
alias dus='du -hd 3 | sort -h'
alias duc='du -hcd 1 | sort -h'
alias dua='du -ah | sort -h'

# NUANCED UTILITIES
alias copy='xsel -i -b' # mainly used to copy the stdout to clipboard
alias re="find . -type f -printf '%T@ %p\n' | sort -k 1 -n | sed 's/^[^ ]* //'" # recursively lists files in dir by modification date
alias opensc="go ~/Pictures/screenshots/$(ls -l ~/Pictures/screenshots/ | awk '{ print $7 }' | tail -1)> /dev/null 2>&1"
alias gpe='command cat /home/musa/pCloudDrive/zMisc./Personal/Accounts/personal/github_token.txt | xsel -i -b && exit'
alias rp='cmd ls -ltr /var/lib/pacman/local/' # lists all pacman packages showing last installed first
alias ytm="mpv --no-video --input-ipc-server=/tmp/mpv-playlist"

# COMMON RENAMES
alias pac="sudo pacman"
alias v='vim'
alias c='clear'
alias e='exit'
alias ls='exa'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -I'
alias cat='cat -n'
alias g='grep -in --color=auto'
alias wl='wc -l'
alias cmd='command'
alias go='gio open'

# NUANCED RENAMES 
alias calc='qalc'
alias show='viu'
alias fm='ranger'
alias diff='diff -syri --color=always'
alias exe='chmod +x'
alias p3='python3'

# GIT UTILITIES
alias clone="git clone"
alias push='git status;echo -ne "Pushing Changes to Github!\n\nEnter commit message: "; read; git add -A; git commit -m "${REPLY}"; git push'
alias gitc='git commit -am'
alias gstat='git status'
alias findgit='find . -name .git -type d -prune'

# SYSTEM UTILITIES
alias die='sleep 120; shutdown'

# VPS CONNECTIONS
alias vps="ssh root@207.90.194.169"
alias vps2="ssh root@158.69.225.140 -p 10950"

# USER PROGRAMS
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias cb='vim ~/.bashrc'
alias cv='vim ~/.vimrc'
alias randman='man $(find /usr/share/man/man1/ | shuf | head -1)'

# SPELLING ERRORS
alias sl='exa'
alias sls="exa"


# EXPORTS 
# --------------------------------------------------
export PATH="$PATH:/home/musa/bin/personal:/home/musa/bin/programs:/home/musa/Downloads/APPS/AppImage:/home/musa/.yarn/bin"

export STARSHIP_CONFIG=~/.config/starship.toml 
export LD_LIBRARY_PATH=/usr/local/lib # export for cs50.h

export HISTCONTROL=ignoredups:erasedups
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export BROWSER=/usr/bin/brave
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TERM=xterm-256color


# zMisc.
# --------------------------------------------------
# bash command not found (also bash insulter if installed)
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# fzf reverse search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# startup 
fortune -as | lolcat
ifetch
eval "$(starship init bash)"
eval "$(zoxide init bash)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

