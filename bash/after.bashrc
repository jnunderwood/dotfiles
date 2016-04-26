# after.bashrc - settings applied after bashrc is processed

# interactive shell? {{{
# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac # }}}

# environment variables {{{
#

# paranoid file permissions
umask 0077

# locale settings
# using "C" is useful for expected sorting of filenames
#export LC_ALL="C.UTF-8"  # use this for foreign character support
export LC_ALL="C"

# prompt: [bold]user@host(time): pwd\n$[offbold]
export PS1="\[\033[1m\]\u@\h(\t): \w\n$\[\033[0m\] "
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
# function settitle { echo -ne "\e]2;$@\a\e]1;$@\a"; }

export PATH=$PATH:~/bin
export EDITOR='/usr/bin/vim'

# settings for 'less'
export PAGER='/usr/bin/less'
export LESS="-EImRX"  # LESS="-M"
#export LESSOPEN="|/usr/local/bin/lesspipe.sh %s"

# Java
JTDS_LIB=$HOME/java/jdbc/jtds-1.2.8.jar
H2_LIB=$HOME/java/jdbc/h2-1.3.171.jar
export CLASSPATH=$JTDS_LIB:$H2_lib
export JAVA_HOME=$HOME/java/jdk17
# export JAVA_HOME='/usr/lib/jvm/java-7-oracle/'

# enable debugging (useful for declare/typeset builtins)
shopt extdebug > /dev/null || shopt -s extdebug

#
# end environment variables }}}

# aliases {{{
#

# aliases for save file operations
alias cp='/bin/cp -ip'
alias mv='/bin/mv -i'
alias rm='/bin/rm -i'

# aliases for colorful greps
alias  grep='/bin/grep  --color=auto'
alias fgrep='/bin/fgrep --color=auto'
alias egrep='/bin/egrep --color=auto'

# unalias default bash settings for 'ls', etc.
# redefined as functions below
unalias ls
unalias ll
unalias la
unalias l

# aliases for process lists
#alias psa='/bin/ps -aelW'
alias  psa='/bin/ps -aux | /bin/grep -v "root |bin |ps |ps -a" | /usr/bin/sort'
alias  psc='/bin/ps -acux | /bin/grep -v "root |bin | ps| grep" | /usr/bin/sort'
alias  pst='/bin/ps -t $tty | /usr/bin/sort'
alias psux='/bin/ps -ux --forest'
alias  psx='/bin/ps -x --forest'
alias  psf='/bin/ps --forest -eo "%P %U %C %a"'
alias  psj='/bin/ps U $USER -o "pid ppid pri %cpu %mem rss stat bsdstart command" "$@"'

# aliases for other stuff
alias      less='/usr/bin/less'
alias      more='/bin/more'
alias         m='$PAGER'
alias        vi='$EDITOR'
alias       vim='/usr/bin/vim'
alias        vp='/usr/local/bin/vimpager'
alias       bak='/bin/cp -p $1 $1.bak'
alias        df='/bin/df -hT'
alias      dusn='/usr/bin/du -BM -s $@ | /usr/bin/sort -n'
alias       who='/usr/bin/w | /usr/bin/sort -u +0.0 -1.0 | $PAGER'
alias    findit='/usr/bin/find . -name $@ -print'
alias  findgrep='/usr/bin/find . -name $@ -exec /bin/grep --color=auto -ls "$@" {} \;'
alias       man='/usr/bin/man -P $PAGER'
alias   manpage='/usr/bin/groff -man $@ | $PAGER'
alias  resource='. ~/.bashrc'
alias  printenv='/usr/bin/printenv | sort'
alias    ssdiff='/usr/bin/sdiff -w$COLUMNS'
alias    whence='type -a'
alias       i3k='/usr/bin/less ~/dotfiles/i3/i3keys.txt'
alias  ldaphelp='~/bin/ldapfind'
alias     notes='$EDITOR ~/Documents/Notes.md'
alias    citrix='/opt/Citrix/ICAClient/selfservice --icaroot /opt/Citrix/ICAClient &'
alias   battery='/usr/bin/upower --show-info /org/freedesktop/UPower/devices/battery_BAT0'
alias    volume='amixer sset Master $1'
alias        suspend='/usr/bin/sudo /usr/sbin/pm-suspend'
alias      hibernate='/usr/bin/sudo /usr/sbin/pm-hibernate'
alias suspend-hybrid='/usr/bin/sudo /usr/sbin/pm-suspend-hybrid'
alias    vpn-connect='/usr/bin/sudo /usr/sbin/vpnc ~/.vpnc.conf'
alias vpn-disconnect='/usr/bin/sudo /usr/sbin/vpnc-disconnect'

# settings for getting around problems in /etc/inputrc and ~/.inputrc
#alias vIm='$EDITOR'
#alias exIt='exit'

#
# end aliases }}}

# functions {{{
#

# "ls" functions {{{
# Notes:
# + aliases do not work very well when using | and $@
# + filename sorting dependent on LC_ALL env variable

function  lf { /bin/ls -CF --group-directories-first $@ | $PAGER -L; }
function   l { /bin/ls -CF        $@ | $PAGER -L; }
function  ll { /bin/ls -hlF       $@ | $PAGER -L; }
function  la { /bin/ls -hlF -A    $@ | $PAGER -L; }
function lla { /bin/ls -hlF -A    $@ | $PAGER -L; }
function  lt { /bin/ls -hlF -rt   $@ | $PAGER -L; }
function lta { /bin/ls -hlF -rtA  $@ | $PAGER -L; }
function ltc { /bin/ls -hlF -rtcA $@ | $PAGER -L; }
function ltu { /bin/ls -hlF -rtuA $@ | $PAGER -L; }
function lls { /bin/ls -hlF -rS   $@ | $PAGER -L; }
function lss { /bin/ls -hlF -rS   $@ | $PAGER -L; }

#
# }}}

# "ldap" functions {{{
#

function ldapuser {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(sAMAccountName=$@)"
    elif [ $# -eq 1 ]; then
        $HOME/bin/ldapfind "(sAMAccountName=$@)"
    else
        $HOME/bin/ldapfind
    fi
}

function ldapemp {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(employeeNumber=$@)"
    elif [ $# -eq 1 ]; then
        $HOME/bin/ldapfind "(employeeNumber=$@)"
    else
        $HOME/bin/ldapfind
    fi
}

#
# }}}

# "which"/"type"/"dlocate" functions {{{
#

function wd  { /usr/bin/dirname `/usr/bin/which $@`; }
function llw { /bin/ls -Fl `/usr/bin/which $@`; }
function mw  { $PAGER `/usr/bin/which $@`; }
function cdw { cd `wd $@`; }
function viw { $EDITOR `/usr/bin/which $@`; }

function where {
    files=`builtin type -a -p $@`
    for file in $files; do
        if [ $file ]; then
            /usr/bin/dlocate -S $file
        fi
    done
}

function which {
    builtin type "$@"
    if [ $? = 0 ]; then
        t=`builtin type -t $@`
        if [ $t = "file" ]; then
            p=`builtin type -p $@`
            /usr/bin/dlocate -S "$p" | /bin/grep " $p$"
        fi
    fi
}

#
# }}}

# miscellaneous functions {{{
#

function get-sink() {
    sink=`/usr/bin/pactl list short sinks | grep RUNNING | cut -f1`
    if [ -z "$sink" ]; then
        sink=0
    fi
    /bin/echo $sink
}

function mute {
    /usr/bin/pactl set-sink-mute `get-sink` 1 && killall -SIGUSR1 i3status
}

function unmute {
    /usr/bin/pactl set-sink-mute `get-sink` 0 && killall -SIGUSR1 i3status
}

function volup {
    unmute
    /usr/bin/pactl set-sink-volume `get-sink` -- +5% && killall -SIGUSR1 i3status
}

function voldown {
    unmute
    /usr/bin/pactl set-sink-volume `get-sink` -- -5% && killall -SIGUSR1 i3status
}

function dashedline {
    if [ -n "$1" ]; then
        count=0
        while [ $count -lt $1 ]; do
            /bin/echo -n "-"
            let count=count+1
        done
        /bin/echo ""
    fi
}

function update {
    /usr/bin/sudo -v
    dashedline 60
    /bin/echo "Updating Packages (no output expected)"
    /usr/bin/sudo /usr/bin/apt-get update -qq
    dashedline 60
    /bin/echo "Upgrading Packages"
    /usr/bin/sudo /usr/bin/apt-get upgrade
    dashedline 60
    /bin/echo "Auto-Removing Packages"
    /usr/bin/sudo /usr/bin/apt-get autoremove
    /bin/echo ""
}

function af {
    /usr/bin/apt-file search bin/$@ | /bin/grep -isv debug | /usr/bin/gawk -F: '{ printf ( "FILE:%-30s PACKAGE: %s\n", $2, $1 ) }' | /usr/bin/sort -dfi | $PAGER
}

function findsize {
    /usr/bin/find . -size +$1$2 -printf "%5k$2: %h/%f\n" | /usr/bin/sort -n
}

function aliasnames {
    alias | /usr/bin/awk -F '=' '{print $1}' | /usr/bin/awk -F ' ' '{print $2}'
}

function unaliasall {
    aliases=`aliasnames`
    for a in $aliases; do
        unalias $a
    done
}

function swap {
    /bin/mv $1 /tmp/tmp.$$
    /bin/mv $2 $1
    /bin/mv /tmp/tmp.$$ $2
}

function svndiff {
    if [ $# = 1 ]; then
        svn cat $1 | /usr/bin/sdiff -w$COLUMNS - $1
    else
        svn cat $2 | /usr/bin/sdiff $1 - $2
    fi
}

#
# }}}

#
# end functions }}}

# vim: set ft=conf fdm=marker:
