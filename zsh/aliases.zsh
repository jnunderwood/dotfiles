# -----------------------------------------------------------------------------
# zsh/bash aliases
# -----------------------------------------------------------------------------

# aliases for save file operations
#alias cp='echo "cp is diabled, use cp -ip"'
#alias mv='echo "mv is diabled, use mv -i"'
#alias rm='echo "rm is diabled, use trash or rm -i"'
alias rm='trash-put'

# aliases for colorful greps
alias  grep='grep  --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# aliases for process lists
#alias psa='ps -aelW'
alias  psa='ps -aux --forest | grep -Ev "root |bin |ps |ps -a" | sort'
alias  psc='ps -acux --forest | grep -Ev "root |bin | ps| grep" | sort'
alias  pst='ps -t $tty | sort'
alias  psx='ps -x --forest'
alias psux='ps -ux --forest'
alias  psg='ps -ux --forest | head -1; ps -ux --forest | grep -v "color"'
alias  psf='ps --forest -eo "%P %U %C %a"'
alias  psj='ps --forest U $USER -o "pid pri %cpu %mem vsz rss size stat bsdstart bsdtime command"'

# aliases for other stuff
alias       resource='export PATH=/bin:/usr/bin; source $HOME/dotfiles/zsh/zshrc'
alias        realias='source $HOME/dotfiles/zsh/aliases.zsh'
alias     refunction='source $HOME/dotfiles/zsh/functions.zsh'
alias             vi='$EDITOR'
alias              m='$PAGER'
alias             mf='$PAGER --style=full'
alias             mm='$HOMEmdr'
alias            cdb='cd `git rev-parse --show-toplevel`'
alias            top='bpytop'
#alias            top='btm'
alias         grails='grails-or-grailsw'
alias            bak='cp -p $1 $1.bak'
alias             df='df -HT'
alias            dus='du -BM -s'
alias             ws='w | sort -u +0.0 -1.0 | $PAGER'
alias           myip='/sbin/ifconfig -a | perl -nle"/(\d+\.\d+\.\d+\.\d+)/ && print $1"'
alias       printenv='printenv | sort'
alias          sdiff='sdiff --width=$COLUMNS'
alias            i3k='$PAGER $HOME/dotfiles/i3/i3keys.txt'
alias       ldaphelp='$HOMEldapfind'
alias          notes='$EDITOR $HOME/Documents/work/Notes.md'
alias            pdf='evince'
alias    compresspdf='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed.pdf $1'
alias    compressjpg='jpegoptim --size=500k $1'
#alias              j='z'
#alias             jj='zz'
#alias              t='$HOMEtodo.sh -a -t -d ./todo.cfg'
alias          todos='$HOMEmdr ~/repos/junderwo/todo/README.md'
alias     colleagues='docker exec -it colleagues.unch.unc.edu sh -c "grep Username /home/app/logs/* | wc -l"'
alias           motd='sudo update-motd'  # 'cat /var/run/motd'
alias         status='inxi -Fix'
#alias        weather='curl wttr.in/rdu'
alias        battery='upower --show-info /org/freedesktop/UPower/devices/battery_BAT1'
alias         volume='amixer sset Master $1'
alias           gksu='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'
alias          jinfo='sudo jinfo `ps aux | grep catalina | grep "^tomcat7" | cut -d" " -f 3`'
alias          whcih='which' # common misspelling
alias        xlogout='gnome-session-quit --logout --force --no-prompt'
alias        suspend='sudo pm-suspend'
alias      hibernate='sudo pm-hibernate'
alias suspend-hybrid='sudo pm-suspend-hybrid'
alias    vpn-connect='echo "second password is push"; sudo openconnect --config=$HOME/.openconnect.conf https://sslvpn.unch.unc.edu'
alias vpn-disconnect='sudo pkill -SIGINT openconnect'
#alias    vpn-connect='sudo vpnc $HOME/.vpnc.conf'
#alias vpn-disconnect='sudo vpnc-disconnect'
#alias        whence='type -a'
#alias        citrix='$ICAROOT/selfservice &'
#alias            man='man -P $PAGER'

#
# vim: set ft=zsh fdm=marker:
