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
#       This helps to prevent code duplication.
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
export PATH=$PATH:~/.envi/bin
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/
export CDPATH='.:..:../..:~/'
# }}}

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

# TODO: Finish this:
## SECTION: Update env {{{1
# _UPDATE_INTERVAL=5000 # Only update if more than this interval has passed
# _UPDATE_SUB_INTERVAL=500000
# _CUR_TIME=$(date +%s)
# source $HOME/.env/.last_update # Get last update timestamp (contains the vars $_LAST_UPDATE and $_LAST_SUB_UPDATE)

# if [ $(($_LAST_UPDATE + $_UPDATE_INTERVAL)) -lt "$_CUR_TIME" ] ; then
#     if [ $(($_LAST_SUB_UPDATE + $_UPDATE_SUB_INTERVAL)) -lt "$_CUR_TIME" ] ; then
#             # Update env and all submodules
#         ~/.env/scripts/env update-all
#             # Change the update timestamp for both vars
#         printf "_LAST_UPDATE="$_CUR_TIME"\n_LAST_SUB_UPDATE="$_CUR_TIME > ~/.env/.last_update
#     else
#             # Update just env
#         ~/.env/scripts/env update
#             # Change the update timestamp just for _LAST_UPDATE
#         printf "_LAST_UPDATE="$_CUR_TIME"\n_LAST_SUB_UPDATE="$_LAST_SUB_UPDATE > ~/.env/.last_update
#     fi
# fi
# }}}

## SECTION: Source .bashrc {{{1
#   Leave this at the bottom
if [ "$BASH" ] && [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
# }}}

# vim:set ft=sh sw=4 fdm=marker:
