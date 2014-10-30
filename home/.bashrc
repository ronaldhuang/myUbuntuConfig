# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#for ubuntu 10.10 menu bug
#“If you set the environment variable UBUNTU_MENUPROXY to 0 ($ export UBUNTU_MENUPROXY=0), and run an afflicted application without closing the Terminal, you will see that the error is resolved.”
export UBUNTU_MENUPROXY=0

PATH=~/bin:$PATH
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups
export HISTCONTROL=erasedups
export HISTIGNORE="cdn:"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | xterm)
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='`a=$?;if [ $a -ne 0 ]; then a="  "$a; echo -ne "\[\e[s\e[1A\e[$((COLUMNS-2))G\e[31m\e[1;41m${a:(-3)}\e[u\]\[\e[0m\e[7m\e[2m\]"; fi`\[\e[1;32m\]\u@\h:\[\e[0m\e[1;34m\]\W\[\e[1;34m\]\$ \[\e[0m\]'
    function prompt
    {
        local WHITE="\[\033[1;37m\]"
        local GREEN="\[\033[1;32m\]"
        local CYAN="\[\033[1;36m\]"
        local GRAY="\[\033[0;37m\]"
        local BLUE="\[\033[0;34m\]"
        local RED="\[\033[1;31m\]"
        local SCREEN_TITLE="33k33\\\\"
        function git_branch {
            ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
            echo "("${ref#refs/heads/}") ";
        }
        function git_since_last_commit {
            now=`date +%s`;
            last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
            seconds_since_last_commit=$((now-last_commit));
            minutes_since_last_commit=$((seconds_since_last_commit/60));
            hours_since_last_commit=$((minutes_since_last_commit/60));
            minutes_since_last_commit=$((minutes_since_last_commit%60));
            
            echo "${hours_since_last_commit}h${minutes_since_last_commit}m ";
        }
        function ps1_now {
            echo `date +%H:%M:%S`
        }
        #export PS1="${GREEN}\u@\h${RED}\$(git_branch)${GRAY}\$(rvm current 2> /dev/null | sed -n 's/..*/ (&)/p') ${CYAN}\w\[\033[0m\] $ "
        export PS1="${BLUE}⌌-${CYAN}[\w] ${GREEN}[\u@\h] ${BLUE}(\$(ps1_now)) ${CYAN}\$(git_branch)\n${BLUE}⌎-\[\033[0m\]$ "
    }

    prompt
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
alias ll='ls -l --color'
alias la='ls -A'
alias l='ls -CF'
alias j='jobs'
alias grep='grep --color'
#alias gvim='LANG=C LESS_TERMCAP_mb='' LESS_TERMCAP_md='' LESS_TERMCAP_me='' LESS_TERMCAP_se='' LESS_TERMCAP_so='' LESS_TERMCAP_ue='' LESS_TERMCAP_us='' gvim'
alias gvim='LANG=en_US.utf8 LESS_TERMCAP_mb='' LESS_TERMCAP_md='' LESS_TERMCAP_me='' LESS_TERMCAP_se='' LESS_TERMCAP_so='' LESS_TERMCAP_ue='' LESS_TERMCAP_us='' gvim'
alias apti='sudo apt-get install'
alias apts='apt-cache search'
alias lt="ls -R|grep :|sed -e 's/:$//;s/[^-][^\/]*\//--/g;s/^/ /;s/-/|/'"
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gl='git log --decorate'
alias go='git checkout '
alias gq='qgit &'
alias got='git '
alias get='git '
alias pwd='python -c "import gtk; cb = gtk.clipboard_get(); cb.set_text(\"$PWD\"); cb.store()"; pwd'
alias ps='ps -A -Lo uname,pid,ppid,pgid,nlwp,lwp,stat,command'

export GTK_IM_MODULE=xim

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

## For colourful man pages (CLUG-Wiki style)
#export LESS_TERMCAP_mb=$'[01;31m'
#export LESS_TERMCAP_md=$'[01;31m'
#export LESS_TERMCAP_me=$'[0m'
#export LESS_TERMCAP_se=$'[0m'
#export LESS_TERMCAP_so=$'[01;44;33m'
#export LESS_TERMCAP_ue=$'[0m'
#export LESS_TERMCAP_us=$'[01;32m'
#
#export JAVA_HOME=/usr/lib/jvm/java-1.5.0-sun

#export DISPLAY=140.113.179.40:0.0
#export JMFHOME=/usr/home/fcwu/Desktop/JMF-2.1.1e 
#export CLASSPATH=$JMFHOME/lib/jmf.jar:.:${CLASSPATH} 
#export LD_LIBRARY_PATH=$JMFHOME/lib:${LD_LIBRARY_PATH}

bind '"\x1b\x5b\x41":history-search-backward'
bind '"\x1b\x5b\x42":history-search-forward'
export HISTCONTROL=erasedups
export HISTTIMEFORMAT='%F %T '

#
# grep
#
alias grepj='find . -path "./out" -prune -o  -type f -name "*\.java" -print0 | xargs -0 grep --color -n'
alias grepc="find . -path "./out" -prune -o  -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' \) -print0 | xargs -0 grep --color -n"
alias grepc1="find . -path "./out" -prune -o  -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' \) -print0 | xargs -0 grep --color -n"
alias greph="find . -path './out' -prune -o  -type f \( -name '*.h' \) -print0 | xargs -0 grep --color -n"
alias grepmk="find . -path './out' -prune -o -type f \( -iname '*.mk' -o -iname 'Makefile' \) -print0 | xargs -0 grep --color -n"
alias grepxml="find . -path './out' -prune -o -type f \( -iname '*.xml' -o -iname 'Makefile' \) -print0 | xargs -0 grep --color -n"
alias grepkc="find . -path './out' -prune -o -type f \( -iname 'kconfig' -o -iname 'Makefile' \) -print0 | xargs -0 grep --color -n"
alias greppy="find . -path './out' -prune -o -type f \( -iname '*.py' \) -print0 | xargs -0 grep --color -n"
alias ff="find . -name"

#
#
#
bind '"\el": "\C-a\C-kll\n"'

function man () {
    /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}

#safe remove, mv the files to .Trash with unique name
#and log the acction
#alias rm=rm-trash
function rm-trash()
{
    trash="$HOME/.Trash"
    log="/var/log/trash.log"
    stamp=`date "+%Y-%m-%d %H:%M:%S"` #current time

    while [ -f "$1" ]; do

        #remove the possible ending /
        file=`echo $1 |sed 's#\/$##' `

        pure_filename=`echo $file  |awk -F / '{print $NF}' |sed -e "s#^\.##" `

        if [ `echo $pure_filename | grep "\." ` ]; then
            new_file=` echo $pure_filename |sed -e "s/\([^.]*$\)/$RANDOM.\1/" `
        else
            new_file="$pure_filename.$RANDOM"
        fi

        trash_file="$trash/$new_file"
        mv "$file" "$trash_file"

        if [ -w $log ]; then
            echo -e "[$stamp]\t$file\t=>\t[$trash_file]" |tee -a $log
        else
            echo -e "[$stamp]\t$file\t=>\t[$trash_file]"
        fi

        shift   #increment the loop
    done
}

function filelist() {
    find . -path './out' -prune -o  -type f -o -path './.repo' -prune
}

function git-export-diff() {
    if [ $# -ne 1 ] ; then
        echo "git-export-diff <version number>"
        return
    fi
    files=`git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT $1 | xargs -0`
    for i in $files 
    do 
        mkdir -p `dirname "$1/$i"`
        echo "$1/$i"
        git show $1:$i > $1/$i
    done
}

#
# ssh loop
#
function sshl() 
{
    timeout=10
    while [ 1 ] ; do 
        ssh "$*"
        read -p "Press any key to re-connect... or wait $timeout seconds to restart" -t $timeout foobar
    done
}

[ -f ~/.git-bash-completion.sh ] && . ~/.git-bash-completion.sh
complete -W "$(echo $(grep '^ssh ' ~/.bash_history | sort -u | sed 's/^ssh //'))" ssh
