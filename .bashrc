

set editing-mode vi
set completion-ignore-case yes

## Bash Aliases
alias cp='cp -v -i'
alias rm='rm -i'
alias mv='mv -i'
alias rsync='rsync -vv'
alias grep='grep --colour=auto'
alias cgrep='grep --colour=always'
alias less='less -R'

alias tmux='TERM='screen-256color' tmux'

alias inchroot='env-update && source /etc/profile && export PS1="(chroot) $PS1"'
alias cdenv='cd ~/.env'
alias ssagent='eval `ssh-agent` && ssh-add ~/.ssh/id_rsa'
alias apache='/etc/init.d/apache2 restart'
alias git-status='git status --ignore-submodules'

####


## Search Program
search () {
    grep -rn $@ ./*
}


#if [ -e /usr/share/terminfo/x/rxvt-unicode ]; then
#   export TERM='rxvt-unicode-256color'
#fi


	if [[ ${EUID} == 0 ]] ; then # must be root:
        if [ -n "$SSH_CLIENT" ] && [ -n "$SSH_CONNECTION" ] ; then # using ssh:
            PS1='\[\033[01;31m\]ssh://\H\[\033[01;34m\] $PWD $(git branch 2>/dev/null | grep -e "\* " | sed "s/^..\(.*\)/[git:\1]/") \n # \[\033[00m\]'
        else # root local
            PS1='\[\033[01;31m\]\h\[\033[01;34m\] $PWD $(git branch 2>/dev/null | grep -e "\* " | sed "s/^..\(.*\)/[git:\1]/") \n # \[\033[00m\]'
        fi
	else # Not root
        if [ -n "$SSH_CLIENT" ] && [ -n "$SSH_CONNECTION" ] ; then # user using ssh
            PS1='\[\033[01;32m\]ssh://\u@\H\[\033[01;34m\] $PWD $(git branch 2>/dev/null | grep -e "\* " | sed "s/^..\(.*\)/[git:\1]/") \n\$\[\033[00m\] '
        else # user local
            PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] $PWD $(git branch 2>/dev/null | grep -e "\* " | sed "s/^..\(.*\)/[git:\1]/") \n\$\[\033[00m\] '
        fi
	fi
