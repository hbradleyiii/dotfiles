#
# name:             .bash_logout
# author:           Harold Bradley III
# email:            harold@bradleystudio.net
# created:          Nov 09 2015
#
# description:      This file is sourced when a login shell terminates.
#

## SECTION: Source .bash_logout_local (if it exists) {{{1
if [[ -f ~/.bash_logout_local ]] ; then
    source ~/.bash_logout_local
fi
# }}}

# Clear the screen for security's sake.
clear
