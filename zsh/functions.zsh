
# "ls" functions {{{
#

# Notes:
# + aliases do not take parameters; use functions instead
# + filename sorting dependent on LC_ALL env variable

# + alternatives to default 'ls':
#   - 'k': zsh plugin - https://github.com/supercrabtree/k/
#   - 'exa': rust program, includes git integration - https://the.exa.website/
#   - 'lsd': rust program, nice colors - https://github.com/Peltoche/lsd

# use default 'ls'
# function  ls { ls --color=always --classify -C $@ }

# use 'k'
#function  ll { k --human --group-directories-first $@ | $PAGER --style=plain }
#function  lt { ll --reverse -t modified $@ | $PAGER --style=plain }
#function ltc { ll --reverse -c --sort modified $@ }
#function lls { ll --reverse -S $@ }

# use 'exa'
#function  ls { exa --classify --color=always --icons --sort name $@ }
#function   l { ls $@ }
#function  lf { ls --group-directories-first $@ }
#function  ll { ls --long --group-directories-first --time-style long-iso --git $@ | $PAGER --style=plain }
#function  lh { ll --help }
#function llh { ll --help }
#function  la { ll --all $@ | $PAGER --style=plain }
#function lla { ll --all $@ | $PAGER --style=plain }
#function lld { ll --only-dirs $@ .* | $PAGER --style=plain }
#function  lt { ls --long --git --sort modified $@ | $PAGER --style=plain }
#function lta { ls --all --long --git --sort modified $@ }
#function ltu { ll -u --sort created $@ }
#function lls { ll --sort size $@ }
#function lss { ll --sort size $@ }
#function ltree { ll --tree --level=3 $@ | $PAGER --style=plain }

# use 'lsd'
function  ls { lsd --classify --color always $@ }
function  lh { ls --help }
function   l { ls $@ }
function  lf { ls --group-dirs first $@ }
function  ll { ls --long --group-dirs first $@ }
function lls { ll --total-size $@ }
function  la { ll --all $@ }
function lla { ll --all $@ }
function lld { ll --directory-only $@ }
function  lt { ll --reverse --sort time $@ }
function lta { lt --all $@ }
function lss { ll --sort size $@ }
function ltree { ll --tree $@ }

#
# }}}

# "ldap" functions {{{
#

function ldapuser {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOMEldapfind $opt "(&(!(!(imrPID=*)))(sAMAccountName=$@))" # | sort -f
    elif [ $# -eq 1 ]; then
        $HOMEldapfind "(&(!(!(imrPID=*)))(sAMAccountName=$@))" # | sort -f
    else
        $HOMEldapfind
    fi
}

function ldapperson {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOMEldapfind $opt "(imrPID=$@)" # | sort -f
    elif [ $# -eq 1 ]; then
        $HOMEldapfind "(imrPID=$@)" # | sort -f
    else
        $HOMEldapfind
    fi
}

function ldapeid {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOMEldapfind $opt "(&(!(!(imrPID=*)))(employeeNumber=$@))" # | sort -f
    elif [ $# -eq 1 ]; then
        $HOMEldapfind "(&(!(!(imrPID=*)))(employeeNumber=$@))" # | sort -f
    else
        $HOMEldapfind
    fi
}

function ldapmail {
    # FIXME: loop through multiple options
    if [ $# -gt 1 ]; then
        opt=$1
        shift
        $HOMEldapfind $opt "(&(!(!(imrPID=*)))(mail=$@))" # | sort -f
    elif [ $# -eq 1 ]; then
        $HOMEldapfind "(&(!(!(imrPID=*)))(mail=$@))" # | sort -f
    else
        $HOMEldapfind
    fi
}

function ldapname {
    # FIXME: loop through multiple options
    if [ $# -gt 2 ]; then
        opt=$1
        shift
        $HOMEldapfind $opt "(&(!(!(imrPID=*)))(&(sn=$1)(givenName=$2)))" # | sort -f
    elif [ $# -eq 2 ]; then
        $HOMEldapfind "(&(!(!(imrPID=*)))(&(sn=$1)(givenName=$2)))" # | sort -f
    elif [ $# -eq 1 ]; then
        $HOMEldapfind "(&(!(!(imrPID=*)))(&(sn=$1)))"
    else
        $HOMEldapfind
    fi
}

#
# }}}

# "which"/"type"/"dlocate" functions {{{
#

function wd  { dirname `which $@`; }
function llw { ll `which $@`; }
function mw  { bat `which $@`; }
function cdw { cd `wd $@`; }
function viw { $EDITOR `which $@`; }

function where2 {
    files=`builtin type -a -p $@ | cut -d' ' -f3`
    for file in $files; do
        if [ $file ]; then
            dlocate -S $file
        fi
    done
}

function which2 {
    builtin type "$@"
    if [ $? = 0 ]; then
        t=`builtin type -w $@ | cut -d' ' -f2`
        if [ $t = "file" ]; then
            p=`builtin type -p $@`
            dlocate -S "$p" | grep --color=auto " $p$"
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
    sink=`pactl list short sinks | grep RUNNING | cut -f1`
    if [ -z "$sink" ]; then
        sink=0
    fi
    echo $sink
}

function mute {
    pactl set-sink-mute `get-sink` 1 && killall -SIGUSR1 i3status
}

function unmute {
    pactl set-sink-mute `get-sink` 0 && killall -SIGUSR1 i3status
}

function volup {
    unmute
    pactl set-sink-volume `get-sink` -- +5% && killall -SIGUSR1 i3status
}

function voldown {
    unmute
    pactl set-sink-volume `get-sink` -- -5% && killall -SIGUSR1 i3status
}

#
# }}}

# docker functions {{{
#

function ctop() {
    docker image pull quay.io/vektorlab/ctop:latest
    docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
}

function docker-health() {
    # docker inspect --format='{{json .State.Health}}' $1.unch.unc.edu | jq
    if [ "$#" -eq 0 ]; then
        server="webapps-un1-p01.unch.unc.edu"
        app="`basename $PWD`.unch.unc.edu"
    elif [ "$#" -eq 1 ]; then
        server="webapps-un1-p01.unch.unc.edu"
        app="${1}.unch.unc.edu"
    else
        if [[ "$2" == "dev" ]]; then
            server="webappsdev1.unch.unc.edu"
            app="${1}dev.unch.unc.edu"
        else
            server="webapps-un1-p01.unch.unc.edu"
            app="${1}.unch.unc.edu"
        fi
    fi
    echo "ssh $server docker inspect --format='{{json .State.Health}}' $app | jq"
    ssh $server "docker inspect --format='{{json .State.Health}}' $app" | jq
}

# usage: docker-logs [appname [dev]]
function docker-logs() {
    if [ "$#" -eq 0 ]; then
        server="webapps-un1-p01.unch.unc.edu"
        app="`basename $PWD`.unch.unc.edu"
    elif [ "$#" -eq 1 ]; then
        if [[ "$1" == "dev" ]]; then
            server="webappsdev1.unch.unc.edu"
            app="`basename $PWD`dev.unch.unc.edu"
        else
            server="webapps-un1-p01.unch.unc.edu"
            app="${1}.unch.unc.edu"
        fi
    else
        if [[ "$2" == "dev" ]]; then
            server="webappsdev1.unch.unc.edu"
            app="${1}dev.unch.unc.edu"
        else
            server="webapps-un1-p01.unch.unc.edu"
            app="${1}.unch.unc.edu"
        fi
    fi
    echo "ssh $server docker logs --tail 500 --follow $app"
    ssh $server docker logs --tail 500 --follow $app
}

function docker-registry-list() {
    docker run --rm anoxis/registry-cli --host https://webtools.unch.unc.edu/ --login unchadmin:hondatoyotaford
}

function docker-registry-clean() {
    docker run --rm anoxis/registry-cli --host https://webtools.unch.unc.edu/ --login unchadmin:hondatoyotaford --delete --num 5
}

function docker-prune() {
    docker system prune
}

function docker-prune-all() {
    docker system prune --all
}

function docker-logins() {
    docker exec -it $1.unch.unc.edu sh -c "grep Username /home/app/logs/* | wc -l"
}

# remove docker images created by "intermediate" build stages
function docker-rmi() {
    docker image remove -f $(docker images -q --filter label=stage=intermediate)
}

#
# }}}

# update functions {{{
#

# replaced by '/usr/sbin/update-motd'
#function motd() {
#    lsb_release -s -d
#    /usr/lib/update-notifier/apt-check --human-readable
#    /usr/lib/ubuntu-release-upgrader/check-new-release -q
#    /usr/lib/update-notifier/update-motd-reboot-required
#}

# update software via apt
function update {
    sudo --validate
    echo ""
    echo "# Updating motd"
    echo "update-motd"
    sudo update-motd

    echo ""
    echo "# Updating Packages (no output expected)"
    echo "apt update -qq --fix-missing"
    sudo apt update -qq --fix-missing

    # apt full-upgrade should do this, plus more
    #sudo --validate
    #echo ""
    #echo "# Upgrading Packages"
    #echo "apt upgrade --with-new-pkgs"
    #sudo apt upgrade --with-new-pkgs
    #echo ""

    sudo --validate
    echo ""
    echo "# Upgrading Distribution, including new kernel packages"
    echo "apt full-upgrade"
    sudo apt full-upgrade

    sudo --validate
    echo ""
    echo "# Auto-Removing Packages"
    echo "apt autoremove"
    sudo apt autoremove

    sudo --validate
    echo ""
    echo "# Auto-Cleaning Local Repository"
    echo "apt-get autoclean"
    sudo apt-get autoclean
}

# update software via cargo
function update-cargo {
    cargo install --list
    echo "cargo install --quiet bat"
    cargo install --quiet bat
    echo "cargo install --quiet bottom"
    cargo install --quiet bottom
    echo "cargo install --quiet git-delta"
    cargo install --quiet git-delta
    echo "cargo install --quiet exa"
    cargo install --quiet exa
    echo "cargo install --quiet fd-find"
    cargo install --quiet fd-find
    echo "cargo install --quiet lsd"
    cargo install --quiet lsd
    echo "cargo install --quiet starship"
    cargo install --quiet starship
    echo "cargo install --quiet tealdeer"
    cargo install --quiet tealdeer
    echo "cargo install --quiet zoxide"
    cargo install --quiet zoxide
    cargo install --list
}

# update software via pip
function update-pip {
    export PYTHONWARNINGS="ignore:Unverified HTTPS request"
    echo "python packages to be upgraded:"
    pip3 show ansible bpytop glances httpie mssql-cli projector-installer testresources docker trash-cli | egrep -i "name|version"
    echo "pip3 install --user --upgrade --quiet ansible"
    pip3 install --user --upgrade --quiet ansible
    echo "pip3 install --user --upgrade --quiet bpytop"
    pip3 install --user --upgrade --quiet bpytop
    echo "pip3 install --user --upgrade --quiet glances"
    pip3 install --user --upgrade --quiet glances
    echo "pip3 install --user --upgrade --quiet httpie"
    pip3 install --user --upgrade --quiet httpie
    echo "pip3 install --user --upgrade --quiet mssql-cli"
    pip3 install --user --upgrade --quiet mssql-cli
    echo "pip3 install --user --upgrade --quiet projector-installer"
    pip3 install --user --upgrade --quiet projector-installer
    echo "pip3 install --user --upgrade --quiet testresources docker"
    pip3 install --user --upgrade --quiet testresources docker
    echo "pip3 install --user --upgrade --quiet trash-cli"
    pip3 install --user --upgrade --quiet trash-cli
    export PYTHONWARNINGS=""
}

# update everything
function update-all {
    update
    update-pip
    update-cargo
}

#
# }}}

# miscellaneous functions {{{
#

# function for Grails; useful for going between Grails 2 and 3+
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

function lg() {
    export LAZYGIT_NEW_DIR_FILE=$HOME/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
        cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
        rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

function weather() {
    if [[ "$1" == "-a" ]]; then
        ansiweather
    elif [[ "$1" == "-1" ]]; then
        curl -sf --compressed wttr.in/rdu?format=4
    elif [[ "$1" == "-h" ]]; then
        curl -sf --compressed wttr.in/:help
    else
        if [[ "$COLUMNS" -lt 125 ]]; then
            curl -sf --compressed wttr.in/rdu?n
        else
            curl -sf --compressed wttr.in/rdu
        fi
    fi
}

# ripgrep piped through a pager
function rg() {
    rg --pretty --smart-case --sort-files $@ | bat
}

function findit() {
    find . -name $@ -print
}

function findgrep() {
    find . -name $@ -exec grep --color=auto -ls "$@" {} \;
}

function findsize {
    find . -size +$1$2 -printf "%5kk: %h/%f\n" | sort -n
}

function manpage() {
    groff -man $@ | $PAGER
}

function dusn() {
    du -BM -s $@ | sort -n
}

function json() {
    if [ -t 0 ]; then
        python -m json.tool <<< "$*" | pygmentize -l json
    else
        python -m json.tool | pygmentize -l json
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

# run a command with sudo
function please() {
    if [ "$1" ]; then
        sudo $@
    else
        # sudo "$BASH" -c "$(history -p !!)"
        cmd=$(fc -ln -1)
        cmd="sudo ${cmd#*    }"
        echo "$cmd"
        # history -s "$cmd"
        print -S "$cmd"
        eval "$cmd"
    fi
}

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
function fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages "$1" | $HOME/.fzffzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
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
    session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | $HOME/.fzffzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
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

function dashedtitle {
    if [ -n "$1" ]; then
        count=0
        while [ $count -lt $1 ]; do
            echo -n "-"
            let count=count+1
        done
        echo ""
        echo $2
    fi
}

function af {
    apt-file search bin/$@ | grep -isv debug | awk -F: '{ printf ( "FILE:%-30s PACKAGE: %s\n", $2, $1 ) }' | sort -dfi | $PAGER
}

function aliasnames {
    # alias | awk -F '=' '{print $1}' | awk -F ' ' '{print $2}'
    alias | awk -F '=' '{print $1}'
}

function unaliasall {
    aliases=`aliasnames`
    for a in $aliases; do
        unalias $a
    done
}

function swap {
    mv $1 /tmp/tmp.$$
    mv $2 $1
    mv /tmp/tmp.$$ $2
}

function svndiff {
    if [ $# = 1 ]; then
        svn cat $1 | sdiff -w$COLUMNS - $1
    else
        svn cat $2 | sdiff $1 - $2
    fi
}

#
# }}}

#
# vim: set ft=zsh fdm=marker:
