
# "ls" functions {{{
#

# Notes:
# + aliases do not take parameters; use functions instead
# + filename sorting dependent on LC_ALL env variable

function  ls { /bin/ls --color=always -CF $@ }
function   l { ls $@ }
function  lf { ls --group-directories-first $@ }
function  ll { ls -hl $@ | $PAGER --style=plain }
function  la { ll -A $@ | $PAGER --style=plain }
function lla { ll -a $@ | $PAGER --style=plain }
function lld { ll -d $@ .* | $PAGER --style=plain }
function  lt { ll -rt $@ | $PAGER --style=plain }
function lta { ll -rtA $@ | $PAGER --style=plain }
function ltc { ll -rtcA $@ | $PAGER --style=plain }
function ltu { ll -rtuA $@ | $PAGER --style=plain }
function lls { ll -rS $@ | $PAGER --style=plain }
function lss { ll -rS $@ | $PAGER --style=plain }
#function chpwd() { ls }

#
# }}}

# "ldap" functions {{{
#

function ldapuser {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(&(!(!(imrPID=*)))(sAMAccountName=$@))"
    elif [ $# -eq 1 ]; then
        $HOME/bin/ldapfind "(&(!(!(imrPID=*)))(sAMAccountName=$@))"
    else
        $HOME/bin/ldapfind
    fi
}

function ldapemp {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(&(!(!(imrPID=*)))(employeeNumber=$@))"
    elif [ $# -eq 1 ]; then
        $HOME/bin/ldapfind "(&(!(!(imrPID=*)))(employeeNumber=$@))"
    else
        $HOME/bin/ldapfind
    fi
}

function ldapmail {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(&(!(!(imrPID=*)))(mail=$@))"
    elif [ $# -eq 1 ]; then
        $HOME/bin/ldapfind "(&(!(!(imrPID=*)))(mail=$@))"
    else
        $HOME/bin/ldapfind
    fi
}

function ldapname {
    # FIXME: loop through multiple options
    if [ $# -gt 2 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(&(!(!(imrPID=*)))(&(sn=$1)(givenName=$2)))"
    elif [ $# -eq 2 ]; then
        $HOME/bin/ldapfind "(&(!(!(imrPID=*)))(&(sn=$1)(givenName=$2)))"
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
function mw  { /usr/bin/bat `/usr/bin/which $@`; }
function cdw { cd `wd $@`; }
function viw { $EDITOR `/usr/bin/which $@`; }

function where2 {
    files=`builtin type -a -p $@ | /usr/bin/cut -d' ' -f3`
    for file in $files; do
        if [ $file ]; then
            /usr/bin/dlocate -S $file
        fi
    done
}

function which2 {
    builtin type "$@"
    if [ $? = 0 ]; then
        t=`builtin type -w $@ | /usr/bin/cut -d' ' -f2`
        if [ $t = "file" ]; then
            p=`builtin type -p $@`
            /usr/bin/dlocate -S "$p" | /bin/grep --color=auto " $p$"
        fi
    fi
}

function pathto () {
    DIRLIST=`echo $PATH|tr : ' '`
    for e in "$@"; do
            for d in $DIRLIST; do
                    test -f "$d/$e" -a -x "$d/$e" && echo "$d/$e"
            done
    done
}

#
# }}}

# audio functions {{{
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

#
# }}}

# miscellaneous functions {{{
#

# alias for Grails; useful for going between Grails 2.x and 3.x
function g() {
    if [[ -a ./grailsw ]]; then
        ./grailsw $@
    else
        grails $@
    fi
}

# ripgrep piped through a pager
function rg() {
    /usr/bin/rg -pS $@ | /usr/bin/bat --theme Darkula
}

function findit() {
    /usr/bin/find . -name $@ -print
}

function findgrep() {
    /usr/bin/find . -name $@ -exec /bin/grep --color=auto -ls "$@" {} \;
}

function manpage() {
    /usr/bin/groff -man $@ | $PAGER
}

function dusn() {
    /usr/bin/du -BM -s $@ | /usr/bin/sort -n
}

# for urxvt terminal; maybe others as well?
function fontsize() {
  # printf '\33]50;%s%d\007' "xft:Bitstream Vera Sans Mono:size=$1::antialias=true:hinting=true"
  if [ $1 ]; then
    printf '\33]50;%s%d\007' "xft:Fira Code:size=$1::antialias=true:hinting=true"
  else
    echo "Specify font size, e.g., $ fontsize 11"
  fi
}

function tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
     tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
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

# replaced by 'update-motd'
#function motd() {
#    /usr/bin/lsb_release -s -d
#    /usr/lib/update-notifier/apt-check --human-readable
#    /usr/lib/ubuntu-release-upgrader/check-new-release -q
#    /usr/lib/update-notifier/update-motd-reboot-required
#}

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
    /usr/bin/sudo --validate
    /bin/echo ""
    /bin/echo "# Updating Packages (no output expected)"
    /bin/echo "apt update -qq --fix-missing"
    /usr/bin/sudo /usr/bin/apt update -qq --fix-missing

    # apt full-upgrade should do this, plus more
    #/usr/bin/sudo --validate
    #/bin/echo ""
    #/bin/echo "# Upgrading Packages"
    #/bin/echo "apt upgrade --with-new-pkgs"
    #/usr/bin/sudo /usr/bin/apt upgrade --with-new-pkgs
    #/bin/echo ""

    /usr/bin/sudo --validate
    /bin/echo ""
    /bin/echo "# Upgrading Distribution, including new kernel packages"
    /bin/echo "apt full-upgrade"
    /usr/bin/sudo /usr/bin/apt full-upgrade

    /usr/bin/sudo --validate
    /bin/echo ""
    /bin/echo "# Auto-Removing Packages"
    /bin/echo "apt autoremove"
    /usr/bin/sudo /usr/bin/apt autoremove

    /usr/bin/sudo --validate
    /bin/echo ""
    /bin/echo "# Auto-Cleaning Local Repository"
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
    # alias | /usr/bin/awk -F '=' '{print $1}' | /usr/bin/awk -F ' ' '{print $2}'
    alias | /usr/bin/awk -F '=' '{print $1}'
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
