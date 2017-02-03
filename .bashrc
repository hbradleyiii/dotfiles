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

## SECTION: Bash Settings {{{1
set -o vi
shopt -s cdspell # Correct directory typos (cd)
shopt -s histappend
shopt -s extglob # Turn on extended globbing
shopt -s checkwinsize  # Fix text wrap when resizing screen
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
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias apache-usr='ps axo user,group,comm | egrep "(apache|httpd)" | grep -v ^root | uniq | cut -d\  -f 1'
alias bh='cat ~/.bash_history | grep'
alias catw='cat /var/lib/portage/world'
alias cd='cd -P'
alias cd..='cd ..'
alias cls='clear'
alias cpb='/bin/cp'
alias cpp='rsync -WavP --human-readable --progress'
alias chrome='google-chrome-stable &'
alias df='df -h'
alias edbash='vim -p ~/.bashrc ~/.bash_profile'
alias edgrub='vim /boot/grub/grub.conf'
alias eixt='exit'
alias free='free -h'
alias fstab='sudo vim /etc/fstab'
alias g='git'
alias ghist='git log --follow -p -- '
alias gitac='git add --all && git commit'
alias gitall='git add --all'
alias gitlog='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gimp='gimp &'
alias grep='grep --color=always'
alias gvim='gvim &'
alias header='curl -I'
alias headerc='curl -I --compress'
alias hosts='sudo vim /etc/hosts'
alias inchroot='env-update && source /etc/profile && export PS1="(chroot) $PS1"'
alias ip='curl http://techterminal.net/myip/ && echo'
alias lip='ifconfig | sed -En "s/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p"'
alias ls='ls -A --color --group-directories-first'
alias lsg='ls -g -h | awk "{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\"%0o \",k);print}"'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ports='netstat -tulanp'
alias q='type -all'
alias reapache='/etc/init.d/apache2 restart'
alias rebash='export EXPORTS_SET=0 ; source ~/.bash_profile'
alias rm='rm -i'
alias skim='(head -5; tail -5) <'
alias speedtest='curl -o /dev/null http://speedtest.sea01.softlayer.com/downloads/test100.zip'
alias speedtest2='wget -O /dev/null http://speedtest.sea01.softlayer.com/downloads/test100.zip'
alias ssagent='eval `ssh-agent` && ssh-add ~/.ssh/id_rsa'
alias ssu='sudo HOME="$HOME" SSH_CLIENT="$SSH_CLIENT" SSH_CONNECTION="$SSH_CONNECTION" bash --rcfile $HOME/.bash_profile'
alias ta='tmux attach'
alias uup='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade'
alias wget='wget -c'
if [[ $MAC_OS && ! $COREUTILS ]] ; then
    unalias ls
    alias ls='ls -A'
    unalias lsg
    alias lsg='ls -Agh'
fi
# }}}

## SECTION: Bash Variables {{{1
ww='/var/www'
# }}}

## SECTION: Tab Completion {{{1
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		source /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		source /etc/bash_completion
	fi
fi

# tab completion for ssh hosts
complete -W "$(
    [[ -f ~/.ssh/known_hosts ]] && echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep --color=never -v "\["`;
    [[ -f ~/.ssh/config ]] && echo `cat ~/.ssh/config | grep --color=never "^Host " | awk '{print $2}'`
)" ssh
complete -W "$(
    [[ -f ~/.ssh/known_hosts ]] && echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep --color=never -v "\["`;
    [[ -f ~/.ssh/config ]] && echo `cat ~/.ssh/config | grep --color=never "^Host " | awk '{print $2}'`
)" ping
complete -W "$(
    [[ -f ~/.ssh/known_hosts ]] && echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep --color=never -v "\["`;
    [[ -f ~/.ssh/config ]] && echo `cat ~/.ssh/config | grep --color=never "^Host " | awk '{print $2}'`
)" dns

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

# Mac tab completion
if [[ $MAC_OS && -f $(brew --prefix)/etc/bash_completion ]]; then
    source $(brew --prefix)/etc/bash_completion
fi
# }}}

## SECTION: Bash Prompts {{{1

# gitstate() {{{2
function gitstate() {

    if ! git rev-parse 2> /dev/null; then return ; fi  # die if not a git repo

    gitroot=$(git rev-parse --show-toplevel)
    if ! test -r "$gitroot/.git/HEAD" ; then echo -e "[permission denied]" ; return ; fi

    local perms=""
    if test -w "$gitroot/.git/HEAD" ; then  # (if writable
        gitfetch  # Automatically do a git fetch at the prompt every 30 minutes
    else
        perms="[RO]"
    fi

    # Check status after fetch
    local git_status="$(git status 2> /dev/null)"

    # find the branch and remove /refs/head/ (or use unnamed branch)
    local git_branch="$(git symbolic-ref HEAD 2>/dev/null)" \
        && git_branch=${git_branch:11} \
        || local git_branch="(unnamed branch)"

    local state=""
    local extended_state=""

    # Check staging area and working directory
    if [[ ! $git_status =~ "working directory clean" ]] ; then
        if [[ $git_status =~ "Changes to be committed:" ]] ; then
            state=$state"(+)"
        elif [[ $git_status =~ "Changes not staged for commit:" ]] ; then
            state=$state"+"
        elif [[ $git_status =~ "Untracked files:" ]] ; then
            state=$state"*"
        fi
    fi

    # Check against remote
    if [[ $git_status =~ "Your branch is ahead of" ]] ; then
        extended_state="(ahead of origin)"
    elif [[ $git_status =~ "Your branch is behind" ]] ; then
        ended_state="(behind origin)"
    fi

    echo -e "[git\x3A"$git_branch$state"] "$extended_state$perms
} # }}}

# TODO: Modify for if colors script doesn't exist
#   Prompt must have double quotes for variable expansion, but single quotes to
#   prevent expansion for commands until expansion in realtime on the prompt.
if [[ ${EUID} == 0 ]] ; then # must be root:
    if [[ -n "$SSH_CLIENT" ]] && [[ -n "$SSH_CONNECTION" ]] ; then # root using ssh:
        PS1="\[${_red}\][ssh] \H\[${_blue}\]"' $( pwd ) $( gitstate )'"\n\[${_blue}\] #\[${_colorreset}\] "
    else # root local
        PS1="\[${_red}\]\h\[${_blue}\]"' $( pwd ) $( gitstate )'"\n\[${_blue}\] #\[${_colorreset}\] "
    fi
else
    if [[ -n "$SSH_CLIENT" ]] && [[ -n "$SSH_CONNECTION" ]] ; then # user using ssh
        PS1="\[${_green}\]ssh://\u@\H\[${_blue}\]"' $( pwd ) $( gitstate )'"\n\[${_blue}\] \$\[${_colorreset}\] "
    else # user local
        PS1="\[${_green}\]\u\[${_blue}\]"' $( pwd ) $( gitstate ) '"\n\[${_blue}\] \$\[${_colorreset}\] "
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

### gitcp - just get the contents of a git repo
# gitcp() {{{2
function gitcp() {
    if [[ "$1" == "" ]] ; then
        echo '[!] gitcp requires a repo to copy from.'
        return
    fi

    if [[ "$2" == "" ]] ; then
        echo '[!] gitcp requires 2 arguments.'
        return
    fi

    echo 'Copying repo $1...'
    git clone --depth=1 --branch=master -- $1 $2 && rm -rf $2/.git
} # }}}

### gitfetch - git fetch
# gitfetch() {{{2
function gitfetch() {
    local current_time=$(date +%s)
	local git_root=$(git rev-parse --show-toplevel)
    local git_fetch_file=$git_root"/.git/FETCH_HEAD"

    # Does the file exist?
    if [[ ! -f $git_fetch_file ]] ; then return ; fi

    # Exit if no internet
    if ! ping -c 1 github.com &> /dev/null ; then return ; fi

    if [[ $MAC_OS && ! $COREUTILS ]] ; then
        eval local `stat -s $git_fetch_file`
        local last_fetch=$st_mtime
    else
        local last_fetch=$(stat -c %Y $git_fetch_file)
    fi
    local next_fetch=$(($last_fetch + 2000))

    # Wait until next time
    if [[ $current_time -lt $next_fetch  ]] ; then return ; fi

    echo -e "\nChecking for updates to ${git_root##*/} repository..."

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

    grep -rnI -- "$1" $DIR | GREP_COLOR="0;39" grep --color=always -ox "^.\{0,250\}"
} # }}}

### sudoh - sudo with my environment
# sudoh() {{{2
function sudoh() {
    sudo bash -i -c "source ~/.bash_profile ; $@"
} # }}}

#### wpl - Moves to the nearest wordpress log directory
# wpl() {{{2
function wpl() {
    local plugin_dir=""
    local current_dir="$(pwd)"
    while [[ "$plugin_dir" == "" ]] ; do
        plugin_dir="$(find "$current_dir" -maxdepth 1 -type d -name "log" | grep --color=never "/log$")"
        current_dir="$(dirname "$current_dir")"  # Next time check parent directory
        if [[ "$current_dir" == "/" ]] ; then
            break # Don't continue to root dir
        fi
    done

    if [[ "$plugin_dir" == "" ]] ; then
        echo 'Directory not found.'
    else
        cd $plugin_dir  # cd to the dir
        ls
    fi
} # }}}

#### wpp - Moves to the nearest wordpress plugin directory
# wpp() {{{2
function wpp() {
    local plugin_dir=""
    local current_dir="$(pwd)"
    while [[ "$plugin_dir" == "" ]] ; do
        plugin_dir="$(find "$current_dir" -type d -name "plugins" | grep --color=never "wp-content/plugins$")"
        current_dir="$(dirname "$current_dir")"  # Next time check parent directory
        if [[ "$current_dir" == "/" ]] ; then
            break # Don't continue to root dir
        fi
    done

    if [[ "$plugin_dir" == "" ]] ; then
        echo 'Directory not found.'
    else
        cd $plugin_dir  # cd to the dir
        ls
    fi
} # }}}

#### wp-perms - From a wordpress root directory, set proper permissions
# wp-perms() {{{2
function wp-perms() {
    if [[ $(wpr) == "Directory not found." ]] ; then
        echo 'WordPress directory not found.'
    else
        echo 'Setting proper WordPress ownership and permissions...'
        chown $(apache-usr):$(apache-usr)  -R * # Let Apache be owner
        find . -type d -exec chmod 775 {} \;  # Change directory permissions rwxrwxr-x
        find . -type f -exec chmod 664 {} \;  # Change file permissions rw-rw-r--
        find 'wp-config.php' -exec chmod 600 {} \;
        find '.htaccess' -exec chmod 600 {} \;
    fi
} # }}}

#### wpr - Moves to the nearest wordpress root directory
# wpr() {{{2
function wpr() {
    local admin_dir=""
    local current_dir="$(pwd)"
    while [[ "$current_dir" != "/" ]] ; do
        if [[ -d "$current_dir/wp-admin" ]] && [[ -d "$current_dir/wp-includes" ]] ; then
            admin_dir="$current_dir"
            break # Don't continue to admin dir
        fi
        current_dir="$(dirname "$current_dir")"  # Next time check parent directory
    done

    if [[ "$admin_dir" == "" ]] ; then
        echo 'Directory not found.'
    else
        # cd to the admin_dir
        cd "$admin_dir"
    fi
} # }}}

#### wpt - Moves to the nearest wordpress theme directory
# wpt() {{{2
function wpt() {
    local plugin_dir=""
    local current_dir="$(pwd)"
    while [[ "$plugin_dir" == "" ]] ; do
        plugin_dir="$(find "$current_dir" -type d -name "themes" | grep --color=never "wp-content/themes$")"
        current_dir="$(dirname "$current_dir")"  # Next time check parent directory
        if [[ "$current_dir" == "/" ]] ; then
            break # Don't continue to root dir
        fi
    done

    if [[ "$plugin_dir" == "" ]] ; then
        echo 'Directory not found.'
    else
        # cd to the dir
        cd "$plugin_dir"

        # If there is only one dir here, cd to it
        if [[ "$(find ./* -maxdepth 0 -type d | wc -l)" == "1" ]] ; then
            cd "$(find ./* -maxdepth 0 -type d)"
        else
            # Otherwise, just show the directories
            find ./* -maxdepth 0 -type d

			# Find the first theme that isn't a twenty* theme.
			for theme_dir in *; do
				if [[ -d $theme_dir ]] && [[ $theme_dir != twenty* ]]; then
					echo "Entering $theme_dir..."
					cd $theme_dir &> /dev/null
					break
				fi
			done
        fi
    fi
} # }}}

#### webmux - web dev tmux setup
# webmux() {{{2
function webmux() {
    if ! [[ -n "$TMUX" ]] ; then  # Are we in tmux?
        tmux has-session -t webmux 2>/dev/null  # See if the session exists

        if [[ $? != 0 ]] ; then  # If it doesn't exist, create it:
            tmux new-session -s webmux -d

            tmux set -g base-index 1
            tmux setw -g pane-base-index 1

            tmux split-window -v -l 5 -t webmux 'sass-watch'
            tmux select-pane -t webmux:1.2
            tmux split-window -h -t webmux 'site-watch'
            tmux select-pane -t webmux:1.1
        fi

        tmux attach -t webmux
    else  # Make this tmux session a webmux-like session
        tmux run-shell 'tmux-sass-watch && tmux-site-watch'
        clear && ls
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
if [[ -e /usr/share/terminfo/x/rxvt-unicode ]] ; then
    export TERM='rxvt-unicode-256color'
fi

## SECTION: Set OLDPWD (if ~/.OLDPWD exists) {{{1
if [[ -f ~/.OLDPWD ]] ; then
    OLDPWD=`cat ~/.OLDPWD`
fi
# }}}

## SECTION: Update dotfiles if necessary {{{1
(cd ~/.dotfiles && gitfetch)
# }}}

## SECTION: Source .bashrc_local (if it exists) {{{1
#   Leave this at the bottom
if [[ -f ~/.bashrc_local ]] ; then
    source ~/.bashrc_local
fi
# }}}

# vim:set ft=sh sw=4 fdm=marker:
