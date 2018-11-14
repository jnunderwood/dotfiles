# Modifed version of 'ys' zsh theme.
# added prompts for git remote status
# modified format and colors of prompt
# 2015/05 - jnunderwood

# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# http://ysmood.org/wp/2013/03/my-ys-terminal-theme/
# Mar 2013 ys

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}[%{$reset_color%}%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[white]%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}o"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" %{$fg_bold[orange]%}<"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" %{$fg_bold[yellow]%}>"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=" %{$fg_bold[red]%}<>"

# Prompt format: \n[TIME] DIRECTORY  BRANCH STATE\n$
PROMPT="
%{$fg_bold[green]%}$(box_name)%{$reset_color%}\
%{$fg[white]%}[%*]\
%{$fg_bold[blue]%} ${current_dir}%{$reset_color%}\
${git_info}
%{$fg[white]%}$ %{$reset_color%}"

# Prompt format: \n # USER@MACHINE  DIRECTORY  BRANCH STATE [TIME] \n $
if [[ "$USER" == "root" ]]; then
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%} \
%{$fg[white]%}@\
%{$fg[green]%}$(box_name)\
%{$fg[white]%}  \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${git_info} \
%{$fg[white]%} [%*]
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
fi
