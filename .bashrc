#
# name:             .bashrc
# author:           Harold Bradley III
# email:            harold@bradleystudio.net
# created:          Wed 02 Jan 2013 11:53:35 AM EST
#
# description:      This file is sourced during an interactive terminal
#                   session.
#

# Exit if this is a non-interactive terminal
if ! [[ $- =~ "i" ]] && ! [[ -n $USE_BASHRC ]] ; then return; fi

# Check if terminal supports colors, if so, source colors
[[ $(tput colors) -ge 8 ]] && [[ -z $_COLORS_DEFINED ]] && source $HOME/.bash_lib/colors

# Check what os we are running
[[ "$(uname)" == "Darwin" ]] && export MAC_OS=true

## SECTION: Bash Settings {{{1
set -o vi
shopt -s cdspell # Correct directory typos (cd)
shopt -s histappend
shopt -s extglob # Turn on extended globbing
bind Space:magic-space # auto-expand history 'magic' (!!)
    # PROMPT_COMMAND is executed before displaying $PS1
PROMPT_COMMAND='history -a ~/.bash_history'
HISTIGNORE='clear:ls:mutt:[bf]g:exit'
HISTCONTROL=ignoredups:ignorespace
# }}}

## SECTION: Bash Aliases {{{1
alias ..='cd ..'
alias .1='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'
alias ~='cd ~'
alias bh='cat ~/.bash_history | grep'
alias catw='cat /var/lib/portage/world'
alias cd='cd -P'
alias cd..='cd ..'
alias cls='clear'
alias cpb='/bin/cp'
alias cpp='rsync -WavP --human-readable --progress'
alias chrome='google-chrome-stable &'
alias df='df -h'
alias edbash='vim -o2 ~/.bashrc ~/.bash_profile'
alias edgrub='vim /boot/grub/grub.conf'
alias eixt='exit'
alias g='git'
alias ghist='git log --follow -p -- '
alias gitac='git add --all && git commit'
alias gitall='git add --all'
alias gitlog='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gimp='gimp &'
alias grep='grep --colour=auto'
alias gvim='gvim &'
alias header='curl -I'
alias headerc='curl -I --compress'
alias inchroot='env-update && source /etc/profile && export PS1="(chroot) $PS1"'
alias ip='curl http://techterminal.net/myip/ && echo'
alias lip='ifconfig | sed -En "s/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p"'
alias ls='ls -A --color --group-directories-first'
alias lsg='ls -A --color --group-directories-first -g -h'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ports='netstat -tulanp'
alias q='type -all'
alias reapache='/etc/init.d/apache2 restart'
alias rebash='source ~/.bash_profile'
alias rm='rm -i'
alias skim='(head -5; tail -5) <'
alias speedtest='curl -o /dev/null http://speedtest.sea01.softlayer.com/downloads/test100.zip'
alias speedtest2='wget -O /dev/null http://speedtest.sea01.softlayer.com/downloads/test100.zip'
alias ssagent='eval `ssh-agent` && ssh-add ~/.ssh/id_rsa'
alias wget='wget -c'
if [[ $MAC_OS ]] ; then
    unalias ls
    alias ls='ls -A'
    unalias lsg
    alias lsg='ls -Agh'
fi
# }}}

## SECTION: Bash Variables {{{1
ww='/var/www'
wp='htdocs/wp-content/theme'
wpt='wp-content/theme'
# }}}

## SECTION: Tab Completion {{{1
# tab completion for ssh hosts
if [[ -f ~/.ssh/known_hosts ]] ; then
    complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
fi

# bash completion for the `wp` command
_wp_complete() {
    local OLD_IFS="$IFS"
    local cur=${COMP_WORDS[COMP_CWORD]}

    IFS=$'\n';  # want to preserve spaces at the end
    local opts="$(wp cli completions --line="$COMP_LINE" --point="$COMP_POINT")"

    if [[ "$opts" =~ \<file\>\s* ]]
    then
        COMPREPLY=( $(compgen -f -- $cur) )
    elif [[ $opts = "" ]]
    then
        COMPREPLY=( $(compgen -f -- $cur) )
    else
        COMPREPLY=( ${opts[*]} )
    fi

    IFS="$OLD_IFS"
    return 0
}
complete -o nospace -F _wp_complete wp
# }}}

## SECTION: Bash Prompts {{{1

# git_state() {{{2
function git_state() {

    if ! git rev-parse 2> /dev/null; then return ; fi  # die if not a git repo

    gitfetch  # Automatically do a git fetch at the prompt every 30 minutes

    # Check status after fetch
    local git_status="$(git status 2> /dev/null)"

    # find the branch and remove /refs/head/ (or use unnamed branch)
    local git_branch="$(git symbolic-ref HEAD 2>/dev/null)" \
        && git_branch=${git_branch:11} \
        || local git_branch="(unnamed branch)"

    # default (just branch)
    local state="[git:"$git_branch"] "

    # Check staging area and working directory
    if [[ ! $git_status =~ "working directory clean" ]] ; then
        state="[git:"$git_branch
        if [[ $git_status =~ "Changes to be committed:" ]] ; then
            state=$state"(+)] "
        elif [[ $git_status =~ "Changes not staged for commit:" ]] ; then
            state=$state"+] "
        elif [[ $git_status =~ "Untracked files:" ]] ; then
            state=$state"*] "
        else
            state=$state"] "
        fi
    fi

    # Check against remote
    if [[ $git_status =~ "Your branch is ahead of" ]] ; then
        state=$state"(ahead of origin)"
    elif [[ $git_status =~ "Your branch is behind" ]] ; then
        state=$state"(behind origin)"
    fi

    echo $state
} # }}}

# TODO: Modify for if colors script doesn't exist
#   Prompt must have double quotes for variable expansion, but single quotes to
#   prevent expansion for commands until expansion in realtime on the prompt.
if [[ ${EUID} == 0 ]] ; then # must be root:
    if [[ -n "$SSH_CLIENT" ]] && [[ -n "$SSH_CONNECTION" ]] ; then # root using ssh:
        PS1="\[${_red}\][ssh] \H\[${_blue}\]"' $( pwd ) $( git_state )'"\n\[${_blue}\] #\[${_colorreset}\] "
    else # root local
        PS1="\[${_red}\]\h\[${_blue}\]"' $( pwd ) $( git_state )'"\n\[${_blue}\] #\[${_colorreset}\] "
    fi
else
    if [[ -n "$SSH_CLIENT" ]] && [[ -n "$SSH_CONNECTION" ]] ; then # user using ssh
        PS1="\[${_green}\]ssh://\u@\H\[${_blue}\]"' $( pwd ) $( git_state )'"\n\[${_blue}\] \$\[${_colorreset}\] "
    else # user local
        PS1="\[${_green}\]\u\[${_blue}\]"' $( pwd ) $( git_state ) '"\n\[${_blue}\] \$\[${_colorreset}\] "
    fi
fi

    # PS2 is the secondary prompt when entering a multiple line command
PS2="\[${_blue}\] -> \[${_colorreset}\]"
    # PS3 is displayed when using select in bash script
PS3=" ->> "
    # PS4 is used before debug lines (when using /bin/bash -x)
PS4='+ ${FUNCNAME[0]:+${FUNCNAME[0]}():} line ${LINENO}: '
# }}}

## SECTION: Bash Functions {{{1
### cl - cd && ls
# cl() {{{2
function cl() {
    cd -- "$@" && ls;
} # }}}

### cp - Copy Wrapper
# cp() {{{2
function cp() {
        echo $1
        echo $2
        echo $3
        echo $4
    if [[ "$1" == "" ]] || [[ "$2" == "" ]] ; then
        echo '[!] cp requires 2 arguments.'
        return
    fi

    #This doesn't work, globbing happens BeFORE this script.

    # If the files have chars that are not valid filename chars,
    # let cp handle them, to allow passing globs through.
    if [[ ! '$1' =~ ^[a-zA-Z0-9_-]*$ ]] || [[ ! '$2' =~ ^[a-zA-Z0-9_-]*$ ]] ; then
        /bin/cp -vri -- "$1" "$2"
        return
    fi

    echo 'hi'

    if [[ -d $1 ]] ; then # Is first arg a directory?
        path=$2
    elif [[ -f $1 ]] ; then  # First arg is a file
        possible_path=`expr match "$2" '\(.*\)\/[^/]*'`
        possible_file=`expr match "$2" '.*\/\(.*\)'`
        if [[ $possible_file == "" ]] ; then
            path=$possible_path
        else
            echo -n "[?] Copy to file '$2'? Answering no will treat '$2' as a directory. (Y/N) "
            while read -r -n 1 -s _ANSWER; do
                if [[ $_ANSWER = [Yy] ]] ; then
                    path=$possible_path
                    break
                elif [[ $_ANSWER = [Nn] ]] ; then
                    path=$2
                    break
                fi
            done
        fi
    else # First arg is invalid
        echo "[!] '$1' does not exist."
    fi

    if [[ ! -d "$path" ]] ; then
        mkdir -p $path
    fi

    /bin/cp -vri -- $1 $2
} # }}}

### cr - CD using Ranger
# cr() {{{2
function cr() {
    tempfile=$(mktemp)
    ranger --choosedir="$tempfile" "$(pwd)"

    if [[ -f "$tempfile" ]] ; then
        cd -- "$(cat -- "$tempfile")"
        rm -f -- "$tempfile"
    fi
} # }}}

### dns - dns information
# dns() {{{2
function dns() {
    if [[ $1 == '' ]] ; then
        echo 'Must specify a domain.'
        return
    fi

    echo -e "\nNameservers:"
    dig +trace NS "$1" | grep -- "$1.*NS"

    if [[ $? -ne 0 ]] ; then
        echo 'Domain not found.'
        return
    fi

    echo -e "\nA Records:"
    dig +trace A "$1" | grep -- "$1.*A"

    echo -e "\nMX Records:"
    dig +trace MX "$1" | grep -- "$1.*MX"

    echo -e "\nTXT Records:"
    dig +trace TXT "$1" | grep -- "$1.*TXT"

    echo
    /usr/bin/whois -h whois.internic.net -- "$1" | grep 'Registrar:\|Creation Date\|Expiration Date\|Updated Date'

    echo
} # }}}

### gitclone - git clone
# gitclone() {{{2
function gitclone() {
    git clone -- "$1" "$2"
    if [[ $? -ne 0 ]] ; then return ; fi

    read -r -p "Set local user to 'Harold Bradley III' and email to 'hbradleyiii@bradleystudio.net'? `echo -e '\n ' `" -n 1 -s _answer
    echo -e '\n'
    if [[ $_answer = [Yy] ]] ; then
        cd -- "$2"
        git config user.name "Harold Bradley III"
        git config user.email "hbradleyiii@bradleystudio.net"
        cd -
    fi
} # }}}

### gitfetch - git fetch
# gitfetch() {{{2
function gitfetch() {
    local current_time=$(date +%s)
    local git_fetch_file=$(git rev-parse --show-toplevel)"/.git/FETCH_HEAD"

    # Does the file exist?
    if [[ ! -f $git_fetch_file ]] ; then return ; fi

    if [[ $MAC_OS ]] ; then
        eval local `stat -s $git_fetch_file`
        local last_fetch=$st_mtime
    else
        local last_fetch=$(stat -c %Y $git_fetch_file)
    fi
    local next_fetch=$(($last_fetch + 2000))

    # Wait until next time
    if [[ $current_time -lt $next_fetch  ]] ; then return ; fi

    # Do the fetch
    git fetch

    # Prompt to merge
    if [[ $(git status 2> /dev/null) =~ "Your branch is behind" ]] ; then
        read -r -p "Merge origin into branch? `echo -e '\n ' `" -n 1 -s _answer
        echo -e '\n'
        if [[ $_answer = [Yy] ]] ; then
            git merge origin
            echo -e '\n'
        fi
    fi
} # }}}

### gitloop - git loop
# gitloop() {{{2
function gitloop() {
    for i in ./* ; do
        echo
        echo $i
        cd $i
        local git_status="$(git status 2> /dev/null)"
        git status
        if [[ ! $git_status =~ "nothing to commit" ]] ; then
            echo 'Dropping to prompt:'
            echo '[Type "exit" to continue loop, or "exit 1" to quit gitloop.]'
            /bin/bash
            if [[ $? != 0 ]] ; then echo 'Exiting...' ; break ; fi
        fi
        cd ..
    done
    echo 'Finished.'
} # }}}

### extract - Extract Program
# extract() {{{2
function extract() {
    if [[ -f $1 ]] ; then
        case $1 in
            # Note that order is important! (ie, .tar.gz must come before .tar)
            *.rar)       unrar x -- $1       ;;
            *.tar.bz2)   tar -xvjf $1        ;;
            *.bz2)       bunzip2 -- $1       ;;
            *.tar.gz)    tar -xvzf $1        ;;
            *.gz)        gunzip -- $1        ;;
            *.tar.xz)    tar -Jxvf $1        ;;
            *.tar.Z)     tar -xzf $1         ;;
            *.tar)       tar -xvf $1         ;;
            *.taz)       tar -xzf $1         ;;
            *.tb2)       tar -xjf $1         ;;
            *.tbz2)      tar --xvjf $1       ;;
            *.tbz)       tar -xvjf $1        ;;
            *.tgz)       tar -xvzf $1        ;;
            *.txz)       tar -Jxvf $1        ;;
            *.zip)       unzip -- $1         ;;
            *.Z)         uncompress -- $1    ;;
            *.7z)        7z x -- $1          ;;
        esac
    else
        echo "'$1' cannot be extracted."
    fi
} # }}}

### manf - search man page $1 for flag $2
# manf() {{{2
function manf() {
    if [[ $2 == '' ]] ; then
        echo 'Please provide a flag to search for.' && return
    elif [[ ${#2} == 1 ]] ; then
        dash='\-'
    else
        dash='\-\-'
    fi
    man -- $1 | sed -n "/^[ ]*$dash$2/,/^$/p" | less
} # }}}

### mans - search man page $1 for term $2
# mans() {{{2
function mans() {
    man -- $1 | grep -iC2 "$2" | less
} # }}}

### path - displays path order in human readable format
# path() {{{2
function path(){
    old=$IFS
    IFS=:
    printf "%s\n" $PATH
    IFS=$old
} # }}}

### s - Search Program
# s() {{{2
function s() {
    if [[ "$1" == "" ]] ; then
        echo 's is a search program.'
        echo ''
        echo 'uses:'
        echo '    grep -rnI -- "string" /the/path'
        echo ''
        echo 'usage:'
        echo '    s 'string' /the/path'
        echo ''
        return
    fi

    if [[ -n "$2" ]] ; then
        DIR=$2
    else
        DIR='./*'
    fi

    grep -rnI -- $1 $DIR
} # }}}

### sudoh - sudo with my environment
# sudoh() {{{2
function sudoh() {
    sudo bash -i -c "$@"
} # }}}

### emux - tmux setup for emerge
# emux() {{{2
function emux() {
    tmux has-session -t emux 2>/dev/null

    if [[ $? != 0 ]] ; then

        tmux new-session -s emerge -d

        tmux set -g base-index 1
        tmux setw -g pane-base-index 1

        tmux split-window -v -l 5 -t emerge
        tmux select-pane -t emerge:1.1
        tmux split-window -v -l 3 -t emerge
        tmux select-pane -t emerge:1.1
        tmux split-window -h -p 50 -t emerge
        tmux select-pane -t emerge:1.1

        tmux send-keys -t emerge:1.1 'cd ~ && clear' C-m
        tmux send-keys -t emerge:1.2 'cd /etc/portage && clear' C-m
        tmux send-keys -t emerge:1.2 'vim -p make.conf package.use package.accept_keywords package.license' C-m
        tmux send-keys -t emerge:1.3 'clear && tail -f /var/log/emerge-fetch.log' C-m
        tmux send-keys -t emerge:1.4 'clear && tail -f /var/log/emerge.log' C-m

    fi

    tmux attach -t emerge
} # }}}

#### webmux - web dev tmux setup
# webmux() {{{2
function webmux() {
    if ! [[ -n "$TMUX" ]] ; then
        tmux has-session -t webmux 2>/dev/null

        if [[ $? != 0 ]] ; then
            tmux new-session -s webmux -d

            tmux set -g base-index 1
            tmux setw -g pane-base-index 1

            tmux split-window -v -l 5 -t webmux 'clear && compass-watch'
            tmux select-pane -t webmux:1.1
            tmux send-keys -t webmux:1.1 'clear && ls' C-m
        fi

        tmux attach -t webmux
    else
        clear
        ls
        tmux split-window -v -l 5 -t webmux 'clear && compass-watch'
        tmux select-pane -U
    fi
} # }}}

### what (which)
# what() {{{2
function what() {
    type -- "$1" 2> /dev/null
    if [[ $? -ne 0 ]] ; then
        echo "$1 not found."
        return
    fi

    which -- "$1"
    if [[ $? -eq 0 ]] ; then
        which -- "$1" | xargs ls -la
    fi
} # }}}

### whois
# whois() {{{2
function whois() {
    local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
    if [[ -z $domain ]] ; then
        domain=$1
    fi
    echo "Getting whois record for: $domain ."

    /usr/bin/whois -h whois.internic.net -- $domain | sed '/NOTICE:/q'
} # }}}

# }}}

#TODO: Fix this:
#if [[ -e /usr/share/terminfo/x/rxvt-unicode ]] ; then
    export TERM='rxvt-unicode-256color'
#fi

## SECTION: Set OLDPWD (if ~/.OLDPWD exists) {{{1
if [[ -f ~/.OLDPWD ]] ; then
    OLDPWD=`cat ~/.OLDPWD`
fi
# }}}

## SECTION: Source .bashrc_local (if it exists) {{{1
#   Leave this at the bottom
if [[ -f ~/.bashrc_local ]] ; then
    source ~/.bashrc_local
fi
# }}}

# vim:set ft=sh sw=4 fdm=marker:
