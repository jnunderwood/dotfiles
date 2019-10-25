# -----------------------------------------------------------------------------
# zsh/bash aliases
# -----------------------------------------------------------------------------

# unalias 'ls'; use functions instead
#unalias ls
#unalias l
#unalias la
#unalias ll
#unalias lsa

# aliases for save file operations
#alias cp='echo "cp is diabled, use /bin/cp -ip"'
#alias mv='echo "mv is diabled, use /bin/mv -i"'
#alias rm='echo "rm is diabled, use /usr/bin/trash or /bin/rm -i"'
alias rm='/usr/bin/trash'

# aliases for colorful greps
alias  grep='/bin/grep  --color=auto'
alias fgrep='/bin/fgrep --color=auto'
alias egrep='/bin/egrep --color=auto'

# aliases for git
#alias gs='/usr/bin/git status'
#alias ga='/usr/bin/git add'
#alias gb='/usr/bin/git branch'
#alias gc='/usr/bin/git commit'
#alias gd='/usr/bin/git diff'
#alias go='/usr/bin/git checkout'
#alias gk='/usr/bin/gitk --all &'
#alias gx='/usr/bin/gitx --all'

# aliases for process lists
#alias psa='/bin/ps -aelW'
alias  psa='/bin/ps -aux --forest | /bin/grep -Ev "root |bin |ps |ps -a" | /usr/bin/sort'
alias  psc='/bin/ps -acux --forest | /bin/grep -Ev "root |bin | ps| grep" | /usr/bin/sort'
alias  pst='/bin/ps -t $tty | /usr/bin/sort'
alias  psx='/bin/ps -x --forest'
alias psux='/bin/ps -ux --forest'
alias  psg='/bin/ps -ux --forest | /usr/bin/head -1; /bin/ps -ux --forest | /bin/grep -v "color" | /bin/grep --color=auto'
alias  psf='/bin/ps --forest -eo "%P %U %C %a"'
alias  psj='/bin/ps --forest U $USER -o "pid pri %cpu %mem vsz rss size stat bsdstart bsdtime command"'

# aliases for other stuff
alias       resource='export PATH=/bin:/usr/bin; source $HOME/dotfiles/zsh/zshrc'
alias        realias='source $HOME/dotfiles/zsh/aliases.zsh'
alias     refunction='source $HOME/dotfiles/zsh/functions.zsh'
alias              m='$PAGER'
alias             mf='$PAGER --style=full'
alias             vi='$EDITOR'
alias         grails='grails-or-grailsw'
alias            bak='/bin/cp -p $1 $1.bak'
alias             df='/bin/df -HT'
alias            dus='/usr/bin/du -BM -s'
alias             ws='/usr/bin/w | /usr/bin/sort -u +0.0 -1.0 | $PAGER'
alias           myip='ifconfig -a | perl -nle"/(\d+\.\d+\.\d+\.\d+)/ && print $1"'
alias       printenv='/usr/bin/printenv | sort'
alias          sdiff='/usr/bin/sdiff --width=$COLUMNS'
alias            i3k='$PAGER $HOME/dotfiles/i3/i3keys.txt'
alias       ldaphelp='$HOME/bin/ldapfind'
alias          notes='$EDITOR $HOME/Documents/Notes.md'
alias           todo='$PAGER $HOME/repos/$USER/todo/README.md'
alias            pdf='/usr/bin/evince'
alias              j='z'
alias              t='$HOME/bin/todo.sh -a -t -d ./todo.cfg'
alias     colleagues='/usr/bin/docker exec -dt colleagues.unch.unc.edu "/bin/grep Username /var/log/colleagues/* | /usr/bin/wc -l"'
alias           motd='/usr/bin/sudo update-motd'  # '/bin/cat /var/run/motd'
alias         status='/usr/bin/inxi -Fix'
#alias        weather='/usr/bin/curl wttr.in/rdu'
alias        battery='/usr/bin/upower --show-info /org/freedesktop/UPower/devices/battery_BAT1'
alias         volume='/usr/bin/amixer sset Master $1'
alias           gksu='/usr/bin/pkexec /usr/bin/env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'
alias          jinfo='/usr/bin/sudo /usr/bin/jinfo `ps aux | grep catalina | grep "^tomcat7" | cut -d" " -f 3`'
alias          whcih='which' # common misspelling
alias        suspend='/usr/bin/sudo /usr/sbin/pm-suspend'
alias      hibernate='/usr/bin/sudo /usr/sbin/pm-hibernate'
alias suspend-hybrid='/usr/bin/sudo /usr/sbin/pm-suspend-hybrid'
alias    vpn-connect='echo "second password is push"; /usr/bin/sudo /usr/sbin/openconnect --config=$HOME/.openconnect.conf https://sslvpn.unch.unc.edu'
alias vpn-disconnect='/usr/bin/sudo /usr/bin/pkill -SIGINT openconnect'
#alias    vpn-connect='/usr/bin/sudo /usr/sbin/vpnc $HOME/.vpnc.conf'
#alias vpn-disconnect='/usr/bin/sudo /usr/sbin/vpnc-disconnect'
#alias        whence='type -a'
#alias        citrix='$ICAROOT/selfservice &'
#alias            man='/usr/bin/man -P $PAGER'

#
# vim: set ft=zsh fdm=marker:
