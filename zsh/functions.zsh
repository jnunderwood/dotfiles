
# "ls" functions {{{
# Notes:
# + aliases do not work very well when using | and $@
# + filename sorting dependent on LC_ALL env variable

function  ls { /bin/ls --color=always -CF $@; } # /bin/ls --color=auto -CF $@; }
function   l { ls       $@ ; } # | $PAGER -L; }
function  lf { ls       $@ ; } # --group-directories-first $@; } # | $PAGER -L; }
function  ll { ls -hl   $@ | $PAGER -L; }
function  la { ll -A    $@ | $PAGER -L; }
function lla { ll -a    $@ | $PAGER -L; }
function  lt { ll -rt   $@ | $PAGER -L; }
function lta { ll -rtA  $@ | $PAGER -L; }
function ltc { ll -rtcA $@ | $PAGER -L; }
function ltu { ll -rtuA $@ | $PAGER -L; }
function lls { ll -rS   $@ | $PAGER -L; }
function lss { ll -rS   $@ | $PAGER -L; }

#function chpwd() {
#  ls
#}

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

function ldapmail {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(mail=$@)"
    elif [ $# -eq 1 ]; then
        $HOME/bin/ldapfind "(mail=$@)"
    else
        $HOME/bin/ldapfind
    fi
}

function ldapname {
    # FIXME: loop through multiple options
    if [ $# -gt 2 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(&(sn=$1)(givenName=$2))"
    elif [ $# -eq 2 ]; then
        $HOME/bin/ldapfind "(&(sn=$1)(givenName=$2))"
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

function where_old {
    files=`builtin type -a -p $@`
    for file in $files; do
        if [ $file ]; then
            /usr/bin/dlocate -S $file
        fi
    done
}

function which_old {
    builtin type "$@"
    if [ $? = 0 ]; then
        t=`builtin type -t $@`
        if [ $t = "file" ]; then
            p=`builtin type -p $@`
            /usr/bin/dlocate -S "$p" | /bin/grep --color=auto " $p$"
        fi
    fi
}

#
# }}}

# miscellaneous functions {{{
#

# for urxvt terminal; maybe others as well?
function fontsize() {
    printf '\33]50;%s%d\007' "xft:Bitstream Vera Sans Mono:size=$1::antialias=true:hinting=true"
}

function hc() {
    /usr/bin/herbstclient "$@"
}

function man () {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

function motd() {
    /usr/bin/lsb_release -s -d
    /usr/lib/update-notifier/apt-check --human-readable
    /usr/lib/ubuntu-release-upgrader/check-new-release -q
}

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

function dashedtitle {
    if [ -n "$1" ]; then
        count=0
        while [ $count -lt $1 ]; do
            /bin/echo -n "-"
            let count=count+1
        done
        /bin/echo ""
        /bin/echo $2
    fi
}

function update {
    /usr/bin/sudo -v
    /bin/echo "*** Updating Packages (no output expected) ***"
    /bin/echo "apt-get update -qq --fix-missing"
    /usr/bin/sudo /usr/bin/apt-get update -qq --fix-missing
    /bin/echo ""

    /usr/bin/sudo -v
    /bin/echo "*** Upgrading Packages ***"
    /bin/echo "apt-get upgrade --with-new-pkgs"
    /usr/bin/sudo /usr/bin/apt-get upgrade --with-new-pkgs
    /bin/echo ""

    /usr/bin/sudo -v
    /bin/echo "*** Upgrading Distribution ***"
    /bin/echo "apt-get dist-upgrade"
    /usr/bin/sudo /usr/bin/apt-get dist-upgrade
    /bin/echo ""

    /usr/bin/sudo -v
    /bin/echo "*** Auto-Removing Packages ***"
    /bin/echo "apt-get autoremove"
    /usr/bin/sudo /usr/bin/apt-get autoremove
    /bin/echo ""

    /usr/bin/sudo -v
    /bin/echo "*** Auto-Cleaning Local Repository ***"
    /bin/echo "apt-get autoclean"
    /usr/bin/sudo /usr/bin/apt-get autoclean
}

function af {
    /usr/bin/apt-file search bin/$@ | /bin/grep -isv debug | /usr/bin/awk -F: '{ printf ( "FILE:%-30s PACKAGE: %s\n", $2, $1 ) }' | /usr/bin/sort -dfi | $PAGER
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
# vim: set ft=zsh fdm=marker:
