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
#
#     -Order of execution-
# Login Shells:
#       A login shell is when you first login to a computer, when you log in
#       from a tty, or when you login remotely, as in SSH.
# 1. /etc/profile
#       This is the system wide bash profile used for interactive login shells.
# 2. ~/.bash_profile
#       This file is executed for login shells. It is only run the first time
#       you log into a shell. By convention, this file often sources ~/.bashrc.
#       This helps to prevent code duplication. Try to keep only essentials in
#       this file for efficiency.
#
# Non-login Shells:
#       A non-login shell would be opening a terminal from Gnome or KDE or run
#       a new shell after having already logged in.
# 1. /etc/bash.bashrc
#       This is the system wide bash profile used for interactive non-login
#       shells.
#
#       Only the first existing file of the next files is executed:
# 2(a). ~/.bashrc
#       This file is executed for interactive non-login shells. This is where
#       most configuration should be done.
# 2(b). ~/.bash_login
# 2(c). ~/.profile
#       It's probably best to not use the previous files. They exist primarily
#       for historical reasons.
#
# Logout:
# Upon logout ~/.bash_logout is executed
#

## SECTION: Exports {{{1
if [[ $EXPORTS_SET != 1 ]] ; then
    export CDPATH='.:~/'
    export EDITOR=vim
    export EXPORTS_SET=1
    export IP=$(curl -s http://techterminal.net/myip/)
    export LESS='-isMR'
    export PATH=$PATH:~/.bash_lib:~/.bash_lib/local
    export PYTHONPATH=$PYTHONPATH:/usr/local/lib/
    export PYTHONSTARTUP=~/.pythonrc.py
    if [[ -n "$DISPLAY" ]] ; then
        export BROWSER=chrome
        export VISUAL=gvim
    else
        export BROWSER=links
        export VISUAL=vim
    fi
    # Check what os we are running
    [[ "$(uname)" == "Darwin" ]] && export MAC_OS=true
fi
# }}}

## SECTION: SSH keychain {{{1
#   start keychain (if it's installed)
#
#   Note: Any script that needs keychain must also call this explicitly,
#   since this is only sourced for login shells.
#
#   Note: Use this command to clear keys:
#       keychain --clear
if [[ -f /usr/bin/keychain ]] ; then
    /usr/bin/keychain ~/.ssh/id_rsa
    source ~/.keychain/$(hostname)-sh > /dev/null
fi
# }}}

## SECTION: Banner displaying tmux sessions {{{1
#   list tmux sessions (if it's installed)
if [[ -f /usr/bin/tmux ]] ; then
    tmux_sessions=$(/usr/bin/tmux ls 2> /dev/null)
    if [[ ! -z $tmux_sessions ]] ; then
        echo -e " \e[1;39m*\e[39m Running \e[32mtmux\e[39m sessions:"
        /usr/bin/tmux ls
        echo
    fi
fi
# }}}

## SECTION: Banner displaying domain and IP {{{1
if [[ $MAC_OS ]] ; then
    printf -e " \e[1;39m*\e[39m Welcome to \e[32m $(hostname) \e[39m [ $IP ]"
    echo
else
    echo -e " \e[1;39m*\e[39m Welcome to \e[32m $(hostname) \e[39m [ $IP ]"
    echo
fi
# }}}

## SECTION: Source .bashrc {{{1
#   Leave this at the bottom
if [[ $- =~ "i" ]] && [[ "$BASH" ]] && [[ -f ~/.bashrc ]] ; then
    source ~/.bashrc
fi
# }}}

# vim:set ft=sh sw=4 fdm=marker:
