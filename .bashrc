# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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

# some more ls aliases
# Aliases

alias mars='java -jar Mars4_5.jar'

alias cp='cp -Rv'
alias ls='ls --color=auto -ACF'
alias ll='ls --color=auto -alF'
alias grep='grep --color=auto'
alias grepw='grep --color=auto -Hrnwi'
alias mkdir='mkdir -pv'
alias mv='mv -v'
alias weather='curl wttr.in/?0'
alias wget='wget -c'
alias tree="tree -aI 'test*|.git|node_modules|resources'"

# Git aliasas
alias gcom='git commit'
alias gsup='git status'
alias goto='git checkout'
alias branches='git branch -v'
alias firewood='for remote in `git branch -r`; do git branch --track ${remote#origin/} $remote; done'
alias remotes='git remote -v'

# virtualenv aliasas
alias mkenv='python3 -m venv env'
alias startenv='source env/bin/activate && which python3'
alias stopenv='deactivate'

# Python
alias python='python3'
alias pip='pip3'
alias ipython='ipython3'

# Code editors aliasas
alias c='code .'
alias i='intellij-idea-community .'
alias a='android-studio .'

# Docker aliasas
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'
alias prtn='sudo protonvpn'

# make yourself look all busy and fancy to non-technical people
alias busy="cat /dev/urandom | hexdump -C | grep --color=always 'ca fe'"

# exit terminal
alias x="exit"

# system reboot
alias rb="sudo reboot"

# list dirs/files in tree format
alias tree="tree -ash -CF --du"

# scan recursively under home directory and load last modified Python file into editor
alias edlast="find '${HOME}' -type f -name '*.py' -printf '%T@ %p\n' | sort --numeric --stable --key=1 | tail -n 1 | cut -d' ' -f2 | ed"

# show last 50 modified files in current dir (recursive)
alias latest="find . -type f -printf '%TY-%Tm-%Td %TR %p\n' 2>/dev/null | grep -v '.git' | sort -n | tail -n 50"

# count all files in current directory (recursive)
alias countfiles="find . -type f | wc -l"

# count installed system packages
alias countpackages="dpkg -l | grep '^ii' | wc -l"

# show counts of file extensions used in current directory (recursive)
alias filetypes="find . -type f | grep -v '.git' | sed -e 's/.*\.//' | sed -e 's/.*\///' | sort | uniq -c | sort -rn"

# color and side-by-side for diffs (requires colordiff package)
alias diff="colordiff -s"

# grep recursively with case-insensitive match and other defaults
alias rgrep="\rgrep \
        --binary-files=without-match \
        --color=auto \
        --devices=skip \
        --ignore-case \
        --line-number \
        --no-messages \
        --with-filename \
        --exclude-dir=.cache \
        --exclude-dir=.git \
        --exclude-dir=.tox \
        --exclude=*.css \
        --exclude=*.js \
        --exclude=*.svg"
alias rg="rgrep"

# navigate up the directory tree
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."
alias cd.......="cd ../../../../../.."
alias cd........="cd ../../../../../../.."

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Red pointer for root
if [ "${UID}" -eq "0" ]; then
    pointerC="${txtred}"
fi

# open a file or URL in the preferred application and hide all console output
open () {
    xdg-open "$@" > /dev/null 2>&1
}
alias o="open"

# show git branch
gitBranch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# search command history by regex (case-insensitive) show last n matches
# usage: h <pattern>
cmdHist () {
    local n="150"
    history | grep -i --color=always "$1" | tail -n "$n"
}

# search process info by regex (case-insensitive)
# usage: psgrep <pattern>
psgrep () {
    ps -ef | grep -i --color=always "$1" | grep -v "grep" | sort -n | less
}

# rename all files in current directory with ".jpeg" extension to ".jpg" and lowercase any .JPG extensions
img-fix-jpg() {
    rename 's/\.jpe?g$/.jpg/i' *
}

# convert all .png and .webp images in the current directory to .jpg format
# save with renamed extensions and delete originals (requires gnu parallel and webp)
convert-images-to-jpgs () {
    findpngs () { find . -maxdepth 1 -type f -iname "*.png" -o -iname "*.webp"; }
    if [[ -n $(findpngs) ]]; then
        ( findpngs | parallel convert -quality 95% {} {.}.jpg ) &&
        ( findpngs | parallel rm {} )
    else
        echo 'nothing to convert'
    fi
}

# list dimensions of images in the current directory
img-sizes () {
    shopt -s nullglob nocaseglob
    for f in  *{gif,jpg,png}; do
        if [[ -e "$f" ]]; then
            identify -ping -format "%[width]x%[height] - $f\n" "$f" 2> /dev/null
        fi
    done
    shopt -u nullglob nocaseglob
}

# expand initial tabs into 4 spaces and convert line endings
# conversion done in-place (requires dos2unix and moreutils packages)
fix-whitespace () {
    if [[ $# -eq 0 ]]; then
        echo "filename argument required"
    else
        expand -i -t 4 "$1" | sponge "$1"
        dos2unix --quiet "$1"
    fi
}

# package maintenance
apt-up () {
    # reload package index files from sources
    sudo apt --no-allow-insecure-repositories update && echo &&
    # upgrade installed packages
    sudo apt full-upgrade && echo &&
    # check for broken dependencies
    sudo apt-get check && echo &&
    # fix broken dependencies
    sudo apt --fix-broken install && echo &&
    # fix missing dependencies
    sudo apt --fix-missing install && echo &&
    # purge packages that are no longer needed
    sudo apt --purge autoremove && echo &&
    # purge orphaned configs from removed packages
    purge-apt-configs &&
    # remove cached packages
    sudo apt clean && echo &&
    # reload package index files from sources
    sudo apt --no-allow-insecure-repositories update && echo &&
    # display package count
    echo "${REVERSEGREEN}$(countpackages) packages currently installed${RESTORE}"
}

eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias FUCK)

# Colours have names too. Stolen from @tomnomnom who stole it from Arch wiki
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;93m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;96m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

# Prompt colours
atC="${txtpur}"
nameC="${txtblu}"
hostC="${txtpur}"
pathC="${txtcyn}"
gitC="${txtpur}"
pointerC="${txtwht}"
normalC="${txtrst}"


export PS1="${pathC}\w ${gitC}\$(gitBranch) ${pointerC}\$${normalC} "

# Vim for life
export EDITOR=/usr/bin/vim

# Bash completion
source ~/.git-completion.bash

# Color prompt
export TERM=xterm-256color

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/adel/.sdkman"
[[ -s "/home/adel/.sdkman/bin/sdkman-init.sh" ]] && source "/home/adel/.sdkman/bin/sdkman-init.sh"

export PATH=/opt/firefox/firefox:$PATH
