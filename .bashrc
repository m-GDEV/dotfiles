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

shopt -s checkwinsize # checks term size when bash regains control
shopt -s expand_aliases # expand aliases so they can use arguments i think
shopt -s cdspell # ignore cd mispellings

bind "set completion-ignore-case on"


# ALIASES
# -------------------------------------------------------------

# COMMON UTILITIES
alias ch='cd ~;clear'
alias cd='z' # to use z program that replaces cd
alias lf='eza --icons -lah'
alias ll='eza --icons -lh'
alias la='eza -a | grep "^\."' # only shows hidden files in dir
alias dus='du -bhd 3 | tee /tmp/du-files && cmd cat /tmp/du-files | sort -h'
alias duc='du -bhcd 1 | sort -h'
alias dua='du -abh | sort -h'
# Shows size of root drive without unecessary directories
alias dufs='du -xbhd 3 --exclude=/{proc,sys,dev,run} 2> /dev/null | tee /tmp/du-files && cmd cat /tmp/du-files | sort -h'

# NUANCED UTILITIES
alias copy='xsel -i -b' # mainly used to copy the stdout to clipboard
alias re="find . -type f -printf '%T@ %p\n' | sort -k 1 -n | sed 's/^[^ ]* //'" # recursively lists files in dir by modification date
alias opensc="viewnior ~/Pictures/screenshots/$( ls -tr ~/Pictures/screenshots/ | tail -1) > /dev/null 2>&1 &"
alias gpe='command cat /home/musa/pCloudDrive/zMisc./Personal/Accounts/personal/github_token.txt | xsel -i -b && exit'
alias spe='command cat /home/musa/pCloudDrive/zMisc./Personal/Accounts/personal/uni-password.txt | xsel -i -b && exit'
alias rp='cmd ls -ltr /var/lib/pacman/local/' # lists all pacman packages showing last installed first
alias ytm="mpv --no-video --input-ipc-server=/tmp/mpv-playlist"
# Sort videos in current dir showing size, length, and filename. Built with help of chatGpt
alias sv='ls --sort=oldest --no-icons *.mp4 | xargs -I {} sh -c '\''length=$(mediainfo --Inform="General;%Duration%" "{}") && du -bh "{}" | awk -v OFS=" | " "{print \$1, $length/1000/60, \$2}"'\'' | column -t | sort -t '\''|'\'' -k2,2n'
alias ports='lsof -i -P -n | grep LISTEN'


# COMMON RENAMES
alias pac="sudo pacman"
alias v='vim'
alias c='clear'
alias e='exit'
alias ls='eza --icons'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -I'
alias cat='cat -n'
alias g='grep -in --color=auto'
alias wl='wc -l'
alias cmd='command'
alias dmg='sudo dmesg -e'

# NUANCED RENAMES
alias calc='qalc'
alias show='viu'
alias fm='ranger'
alias diff='diff -syri --color=always'
alias exe='chmod +x'
alias p3='python3'
alias ts='sudo tlp-stat -s'

# GIT UTILITIES
alias clone="git clone"
alias push='git status;echo -ne "Pushing Changes to Github!\n\nEnter commit message: "; read; git add -A; git commit -m "${REPLY}"; git push'
alias commit='echo -ne "Enter Commit Message: "; read; git add -A; git commit -m "${REPLY}"'
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
alias sl='eza --icons'
alias sls="eza --icons"


# EXPORTS
# --------------------------------------------------
export PATH="$PATH:/home/musa/bin/personal:/home/musa/bin/programs:/home/musa/Downloads/APPS/AppImage:/home/musa/.yarn/bin:/home/musa/.local/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# Eternal, unlimited, saved after every command, bash history
# https://stackoverflow.com/a/19533853/13646445
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoredups:erasedups
export HISTFILE="$HOME/pCloudDrive/zMisc./dotfiles/bash_external_history"
PROMPT_COMMAND="history -a; $PROMPT_COMMAND" # Forces history file to be re-written after every command

export STARSHIP_CONFIG=~/.config/starship.toml
export LD_LIBRARY_PATH=/usr/local/lib # export for cs50.h
export TERM=xterm-256color

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export BROWSER=/usr/bin/brave
export PAGER=/usr/bin/bat

export MANROFFOPT="-c" # Fixes annoying bat ansi error thing check #2568 & #2563 on bat github
export MANPAGER="sh -c 'col -bx | bat --style=plain  -l man -p'"
export MANROFFOPT="-c"


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



