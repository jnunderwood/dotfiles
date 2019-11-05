
# "ls" functions {{{
#

# Notes:
# + aliases do not take parameters; use functions instead
# + filename sorting dependent on LC_ALL env variable
# + for long listings, use 'k' zsh plugin: https://github.com/supercrabtree/k

function  ls { /bin/ls --color=always -CF $@ }
function   l { ls $@ }
function  lf { ls --group-directories-first $@ }
function  ll { k --group-directories-first --human $@ | $PAGER --style=plain }
function  lh { ll --help }
function llh { ll --help }
function  la { ll --almost-all $@ | $PAGER --style=plain }
function lla { ll --all $@ | $PAGER --style=plain }
function lld { ll --directory $@ .* | $PAGER --style=plain }
function  lt { ll --reverse -t $@ | $PAGER --style=plain }
function lta { ll --almost-all --reverse -t $@ | $PAGER --style=plain }
function ltc { ll --almost-all --reverse -ct $@ | $PAGER --style=plain }
function ltu { ll --almost-all --reverse -tu $@ | $PAGER --style=plain }
function lls { ll --reverse -S $@ | $PAGER --style=plain }
function lss { ll --reverse -S $@ | $PAGER --style=plain }
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
        $HOME/bin/ldapfind $opt "(&(!(!(imrPID=*)))(sAMAccountName=$@))" # | /usr/bin/sort -f
    elif [ $# -eq 1 ]; then
        $HOME/bin/ldapfind "(&(!(!(imrPID=*)))(sAMAccountName=$@))" # | /usr/bin/sort -f
    else
        $HOME/bin/ldapfind
    fi
}

function ldapemp {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(&(!(!(imrPID=*)))(employeeNumber=$@))" # | /usr/bin/sort -f
    elif [ $# -eq 1 ]; then
        $HOME/bin/ldapfind "(&(!(!(imrPID=*)))(employeeNumber=$@))" # | /usr/bin/sort -f
    else
        $HOME/bin/ldapfind
    fi
}

function ldapmail {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(&(!(!(imrPID=*)))(mail=$@))" # | /usr/bin/sort -f
    elif [ $# -eq 1 ]; then
        $HOME/bin/ldapfind "(&(!(!(imrPID=*)))(mail=$@))" # | /usr/bin/sort -f
    else
        $HOME/bin/ldapfind
    fi
}

function ldapname {
    # FIXME: loop through multiple options
    if [ $# -gt 2 ]; then
        opt=$1
        shift
        $HOME/bin/ldapfind $opt "(&(!(!(imrPID=*)))(&(sn=$1)(givenName=$2)))" # | /usr/bin/sort -f
    elif [ $# -eq 2 ]; then
        $HOME/bin/ldapfind "(&(!(!(imrPID=*)))(&(sn=$1)(givenName=$2)))" # | /usr/bin/sort -f
    elif [ $# -eq 1 ]; then
        $HOME/bin/ldapfind "(&(!(!(imrPID=*)))(&(sn=$1)))"
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

# function for Grails; useful for going between Grails 2.x and 3.x
function grails-or-grailsw() {
    if [[ -a ./grailsw ]]; then
        echo "executing: ./grailsw"
        ./grailsw $@
    elif [[ -a ./app/grailsw ]]; then
        echo "executing: cd app; ./grailsw"
        cd app
        ./grailsw $@
        cd ..
    else
        echo "executing:" `where grails | grep -v alias`
        command grails $@
    fi
}

# function for Gradle
function gradle-or-gradlew() {
    if [[ -a ./gradlew ]]; then
        echo "executing: ./gradlew"
        ./gradlew $@
    elif [[ -a ./app/gradlew ]]; then
        echo "executing: cd app; ./gradlew"
        cd app
        ./gradlew $@
        cd ..
    else
        echo "executing:" `where gradle | grep -v alias`
        command gradle $@
    fi
}

function weather() {
    if [ "$1" == "-a" ]; then
        /usr/bin/ansiweather
    elif [ "$1" == "-1" ]; then
        /usr/bin/curl -sf --compressed wttr.in/rdu?format=4
    elif [ "$1" == "-h" ]; then
        /usr/bin/curl -sf --compressed wttr.in/:help
    else
        if [ "$COLUMNS" -lt 125 ]; then
            /usr/bin/curl -sf --compressed wttr.in/rdu?n$*
        else
            /usr/bin/curl -sf --compressed wttr.in/rdu?$*
        fi
    fi
}

# ripgrep piped through a pager
function rg() {
    /usr/bin/rg --pretty --smart-case --sort-files $@ | /usr/bin/bat --plain --theme 'Monokai Extended'
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

function ctop() {
    /usr/bin/docker image pull quay.io/vektorlab/ctop:latest
    /usr/bin/docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
}

function healthcheck() {
    /usr/bin/docker inspect --format='{{json .State.Health}}' $1.unch.unc.edu | /usr/bin/jq
}

function json () {
    if [ -t 0 ]; then
        /usr/bin/python -m json.tool <<< "$*" | /usr/bin/pygmentize -l json
    else
        /usr/bin/python -m json.tool | /usr/bin/pygmentize -l json
    fi
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

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
function fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    /usr/bin/rg --files-with-matches --no-messages "$1" | $HOME/.fzf/bin/fzf --preview "highlight -O ansi -l {} 2> /dev/null | /usr/bin/rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || /usr/bin/rg --ignore-case --pretty --context 10 '$1' {}"
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
    local files
    IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
    local out file key
    IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)
    if [ -n "$file" ]; then
        [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
    fi
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}

function tm() {
    [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
    if [ $1 ]; then
         tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
    fi
    session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | $HOME/.fzf/bin/fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
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
    /usr/bin/man "$@"
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
    /usr/bin/find . -size +$1$2 -printf "%5kk: %h/%f\n" | /usr/bin/sort -n
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
