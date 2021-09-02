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

HISTSIZE=2500
HISTFILESIZE=2500

shopt -s checkwinsize # checks term size when bash regains control
shopt -s expand_aliases # expand aliases so they can use arguments i think
shopt -s histappend # Enable history appending instead of overwriting.  #139609
shopt -s cdspell # ignore cd mispellings

bind "set completion-ignore-case on"


# ALIASES 
# -----------------------------------------------------------
# TERMINAL UTILITIES
alias ch='cd ~;clear'
alias c='clear'
alias e='exit'
alias lf='exa -lah'
alias ls='exa'
alias ll='exa -lh'
alias la='exa -a | grep "^\."' #only shows hidden files in dir
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -I'
alias cat='cat -n'
alias show='viu'
alias go='gio open'
alias cmd='command'
alias grep='grep -in --color=auto'
alias dus='du -h | sort -h'
alias dua='du -ah | sort -h'
alias wl='wc -l'
alias fm='ranger'
alias copy='xsel -i -b'
alias gp='command cat /home/musa/pCloudDrive/zMisc./Personal/Accounts/personal/github_token.txt | xsel -i -b'
alias gpe='command cat /home/musa/pCloudDrive/zMisc./Personal/Accounts/personal/github_token.txt | xsel -i -b;exit'
alias calc='qalc'
alias work='cd ~/Documents/working-dir/'
alias findgit='find . -name .git -type d -prune'
alias sc='sakura -d . & clear'
alias se='sakura -d . & exit'
alias rp='cmd ls -ltr /var/lib/pacman/local/' # lists all pacman packages showing last installed first
alias diff='diff -syri --color=always'

# SYSTEM UTILITIES
alias sleeper='sleep 2100;systemctl suspend'
alias die='sleep 120; shutdown'
alias pac="sudo pacman"
alias please='sudo apt'
# alias pip3='python3 -m pip'
alias sshplex='ssh musa@192.168.2.35'
alias zain='ssh zain@192.168.2.80'
alias cr='ccrypt'
alias exe='chmod +x'
alias p3='python3'
# alias cat='bat' # dont like this
alias aic='ascii-image-converter'
alias hi='highlight'
# alias jek='jekyll' # dont use this

# USER PROGRAMS
alias shark='sudo surfshark-vpn'
alias m='ytfzf -m'
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias cb='vim ~/.bashrc'
alias cv='vim ~/.vimrc'
alias randman='man $(find /usr/share/man/man1/ | shuf | head -1)'
# SPELLING ERRORS
alias sl='exa'


# EXPORTS 
# ------------------------------------------------------------
export PATH="/home/musa/bin/personal:$PATH"
export PATH="/home/musa/bin/programs:$PATH"
export PATH="/home/musa/Downloads/APPS/Uncompressed/VSCODE/bin:$PATH"
export PATH="/home/musa/Downloads/APPS/AppImage/:$PATH"
#export PATH="/home/musa/.local/share/gem/ruby/3.0.0/bin:$PATH"

export STARSHIP_CONFIG=~/.config/starship.toml 
export MICRO_TRUECOLOR=1 # idk part of dracula micro theme
export LD_LIBRARY_PATH=/usr/local/lib # export for cs50.h

export HISTCONTROL=ignoredups:erasedups
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export BROWSER=/usr/bin/brave
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TERM=xterm-256color


# zMisc.
# ------------------------------------------------------------
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
