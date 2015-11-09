#
# name:             .bash_profile
# author:           Harold Bradley III
# email:            harold@bradleystudio.net
# created:          Wed 02 Jan 2013 11:53:35 AM EST
#
# description:      This file is sourced during an interactive terminal
#                   session.
#

# NOTES:
# Order of execution:
#
# /etc/profile
# ~/.bash_profile
# ~/.bashrc (if pulled in by the above file)
# ~/.bash_login
# ~/.profile
#
# Upon logout ~/.bash_logout is executed
#

## Export for vars or not?

# Check if terminal supports colors, if so, source colors
#[[ $(tput colors) -ge 8 ]] && [[ -z $_COLORS_DEFINED ]] && source $HOME/.env/scripts/colors

## SECTION: SSH keychain {{{1
#   start keychain (if it's installed)
#
#   Note: Any script that needs keychain must also call this explicitly,
#   since this is .bash_profile.
#
#   Note: Use this command to clear keys:
#       keychain --clear
if [ -f /usr/bin/keychain ]; then
    /usr/bin/keychain ~/.ssh/id_rsa
    source ~/.keychain/$(hostname)-sh > /dev/null
fi
# }}}

## SECTION: Bash Aliases {{{1
# Modify Default Behavior
alias cls='clear'
alias cp='cp -vr'
alias df='df -h'
alias grep='grep --colour=auto'
alias lsg='ls -AhglF'
alias ls='ls -AhF'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias rm='rm -i'
alias rsync='rsync -vv'
alias eixt='exit'
# Shortcuts
alias rebash='source ~/.bash_profile'
alias edbash='vim --remote-silent -o2 ~/.bashrc ~/.bash_profile'
alias edgrub='vim /boot/grub/grub.conf'
alias catw='cat /var/lib/portage/world'
alias inchroot='env-update && source /etc/profile && export PS1="(chroot) $PS1"'
alias cdenv='cd ~/.env'
alias gitlog='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
# }}}

## SECTION: Bash Prompts {{{1

# git_prompt() {{{2
function git_prompt() {
    if [[ -d ".git" ]] ; then 
        _branch="$(git symbolic-ref HEAD 2>/dev/null)" || _branch="(unnamed branch)"
        _branch=${_branch:11} # Clean up "/refs/heads/"
        if [[ $(git status -s 2>/dev/null) != "" ]] ; then
            # changes uncommitted in repository
            _mod="+"
        fi
        echo "[git:"$_branch$_mod"]"
    fi
}
# }}}

#   Prompt must have double quotes for variable expansion, but single quotes to
#   prevent expansion for commands until expansion in realtime on the prompt.
#if [[ ${EUID} == 0 ]] ; then # must be root:
    #if [ -n "$SSH_CLIENT" ] && [ -n "$SSH_CONNECTION" ] ; then # root using ssh:
        #PS1="\[${_redB}\][ssh] \H\[${_blue}\]"' $( pwd ) $( git_prompt )'"\n#\[${_colorreset}\] "
    #else # root local
        #PS1="\[${_redB}\]\h\[${_blue}\]"' $( pwd ) $( git_prompt )'"\n#\[${_colorreset}\] "
    #fi
#else
    #if [ -n "$SSH_CLIENT" ] && [ -n "$SSH_CONNECTION" ] ; then # user using ssh
        #PS1="\[${_greenB}\]ssh://\u@\H\[${_blueB}\]"' $( pwd ) $( git_prompt )'"\n\$\[${_colorreset}\] "
    #else # user local
        #PS1="\[${_greenB}\]\u\[${_blueB}\]"' $( pwd ) $( git_prompt ) '"\n \$\[${_colorreset}\] "
    #fi
#fi

    # PS2 is the secondary prompt when entering a multiple line command
#PS2="\[${_blue}\] -> \[${_colorreset}\]"
    # PS3 is displayed when using select in bash script
PS3=" ->> "
    # PS4 is used before debug lines (when using /bin/bash -x)
PS4='+ ${FUNCNAME[0]:+${FUNCNAME[0]}():} line ${LINENO}: '
    # PROMPT_COMMAND is executed before displaying $PS1
    # Log all commands:
PROMPT_COMMAND='history -a >(tee -a ~/.bash_history | logger -t "$USER [$$] $SSH_CONNECTION")'
# }}}

# path() {{{1
#   prints the order of the path in human readable format
function path(){
    old=$IFS
    IFS=:
    printf "%s\n" $PATH
    IFS=$old
}
# }}}
# extract() {{{1
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via extract" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
# }}}

## SECTION: Source .bashrc {{{1
#   Leave this at the bottom
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
# }}}

# Last Modified:        Thu 10 Jan 2013 01:40:11 AM EST
# vim:set ft=sh sw=4 fdm=marker:
